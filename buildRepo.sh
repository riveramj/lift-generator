#!/bin/bash

# Ask basic app questions
echo "Enter the path for the new lift project:"
read appPath

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

pathsFilePath="$appPath/src/main/scala/$folderStructure/util/Paths.scala"
bootFilePath="$appPath/src/main/scala/bootstrap/liftweb/Boot.scala"

cd $appPath

# Create basic project folder structure
mkdir -p "project"
mkdir -p "src/main/scala/bootstrap/liftweb/"
mkdir -p "src/main/scala/$folderStructure/snippet"
mkdir -p "src/main/scala/$folderStructure/model"
mkdir -p "src/main/scala/$folderStructure/comet"
mkdir -p "src/main/scala/$folderStructure/util"
mkdir -p "src/main/resources/props"
mkdir -p "src/main/webapp/WEB-INF"
mkdir -p "src/main/webapp/templates-hidden"
mkdir -p "src/main/webapp/static"
mkdir -p "src/main/webapp/images"

# Generate .keep files to upload file structure to Github w/o files
touch "src/main/scala/$folderStructure/snippet/.keep"
touch "src/main/scala/$folderStructure/model/.keep"
touch "src/main/scala/$folderStructure/comet/.keep"
touch "src/main/webapp/WEB-INF/.keep"

# Create empty files as placeholders
touch "src/main/webapp/index.html"
touch "src/main/webapp/static/index.html"
touch "src/main/resources/logback.xml"
touch "src/main/resources/props/default.props"
touch "src/main/webapp/templates-hidden/default.html"

# Load files with default values
cp "$scriptStartingFilesPath/build.sbt" "./build.sbt"
cp "$scriptStartingFilesPath/plugins.sbt" "./project/plugins.sbt"
cp "$scriptStartingFilesPath/Boot.scala" $bootFilePath
cp "$scriptStartingFilesPath/Paths.scala" $pathsFilePath

#Replace values in created default files
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
