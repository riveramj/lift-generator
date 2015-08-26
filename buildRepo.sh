#!/bin/bash

echo "Enter the path for the new lift project"
read path

echo "what is the app name"
read appName

echo "what is the app organization [com.example]"
read organization

folderStructure=${organization//"."/"/"}

echo "what is the starting version [0.1-SNAPSHOT]"
read appVersion

echo "what scala version do you want to use [2.11.7]"
read scalaVersion

cp "./startingFiles/build.sbt" $path"/build.sbt"

cd $path

mkdir -p "project"
mkdir -p "src/main/scala"
mkdir -p "src/main/webapp"
mkdir -p "src/main/resources"
mkdir -p "src/main/scala/bootstrap/liftweb"
mkdir -p "src/main/scala/"$folderStructure
mkdir -p "src/main/resources/props"
mkdir -p "src/main/webapp/WEB-INF"
mkdir -p "src/main/webapp/templates-hidden"
mkdir -p "src/main/webapp/static"

touch "project/plugins.sbt"
touch "src/main/resources/logback.xml"
touch "src/main/resources/props/default.props"
touch "src/main/scala/bootstrap/liftweb/Boot.scala"

build=$(sed \
  -e "s/\${appName}/$appName/" \
  -e "s/\${appVersion}/$appVersion/" \
  -e "s/\${organization}/$organization/" \
  -e "s/\${scalaVersion}/$scalaVersion/" \
  "build.sbt")

echo "$build" > "./build.sbt"
