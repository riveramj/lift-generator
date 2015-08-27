#!/bin/bash

echo "Enter the path for the new lift project:"
read path

echo "what is the app name:"
read appName

echo "what is the app organization (format: com.example):"
read organization

folderStructure=${organization//"."/"/"}

appVersionDefault="0.1-SNAPSHOT"
read -p "what is the starting version [$appVersionDefault]: " appVersion
appVersion=${appVersion:-$appVersionDefault}

scalaVersionCurrent="2.11.7"
read -p "what scala version do you want to use? [$scalaVersionCurrent]: " scalaVersion
scalaVersion=${scalaVersion:-$scalaVersionCurrent}

cd "startingFiles"

scriptStartingFilesPath=`pwd`

pathsFilePath="$path/src/main/scala/$folderStructure/util/Paths.scala"
bootFilePath="$path/src/main/scala/bootstrap/liftweb/Boot.scala"

cd $path

mkdir -p "project"
mkdir -p "src/main/scala/bootstrap/liftweb/"
mkdir -p "src/main/scala/$folderStructure/util"
mkdir -p "src/main/resources/props"
mkdir -p "src/main/webapp/WEB-INF"
mkdir -p "src/main/webapp/templates-hidden"
mkdir -p "src/main/webapp/static"

touch "src/main/resources/logback.xml"
touch "src/main/resources/props/default.props"

cp "$scriptStartingFilesPath/build.sbt" "./build.sbt"

cp "$scriptStartingFilesPath/plugins.sbt" "./project/plugins.sbt"

cp "$scriptStartingFilesPath/Boot.scala" $bootFilePath

cp "$scriptStartingFilesPath/Paths.scala" $pathsFilePath

build=$(sed \
  -e "s/\${appName}/$appName/" \
  -e "s/\${appVersion}/$appVersion/" \
  -e "s/\${organization}/$organization/" \
  -e "s/\${scalaVersion}/$scalaVersion/" \
  "build.sbt")
echo "$build" > "./build.sbt"

boot=$(sed -e "s/\${organization}/$organization/" $bootFilePath)
echo "$boot" > $bootFilePath

paths=$(sed -e "s/\${organization}/$organization/" $pathsFilePath)
echo "$paths" > $pathsFilePath
