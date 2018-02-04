#!/bin/bash

scriptDir=`pwd`
startingFilesDir="$scriptDir/startingFiles"

# Ask basic app questions
appPath=""
while [ -z "$appPath" ]; do
  read -p "Enter the path for the new lift project: " appPath
done

if [ ! -d "`eval echo ${appPath}`" ]; then

  createPathResponseDefault="Y"
  createPathResponse=""
  while [[ ! $createPathResponse =~ ^[YNyn]$ ]]; do
    read -p "Path does not exist, create directory? [Y/n]: " createPathResponse
    createPathResponse=${createPathResponse:-$createPathResponseDefault}

    case $createPathResponse in
      [yY]) mkdir -p "`eval echo ${appPath}`";;
      [nN])
        echo "Generator is ending. Thanks!"
        exit
        ;;
      *)  echo "$createPathResponse is not a valid response";;
    esac
  done
fi

cd "`eval echo ${appPath}`"
appPath=`pwd`

appName=""
while [ -z "$appName" ]; do
  read -p "What is the app name: " appName
done

organization=""
while [ -z "$organization" ]; do
  read -p "What is the app organization (format: com.example): " organization
done

folderStructure=${organization//"."/"/"}

appVersionDefault="0.1-SNAPSHOT"
read -p "What is the starting version [$appVersionDefault]: " appVersion
appVersion=${appVersion:-$appVersionDefault}

buildFileChoice=""
while [[ ! $buildFileChoice =~ ^[1-2]$ ]]; do
  read -p "Choose a build file to use. 
    [1] build.sbt 
    [2] build.scala
  " buildFileChoice
done
scalaVersionCurrent="2.12.4"

#read -p "What scala version do you want to use? [$scalaVersionCurrent]: " scalaVersion
#scalaVersion=${scalaVersion:-$scalaVersionCurrent}

scalaVersion=$scalaVersionCurrent

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

mkdir -p "src/test/resources"
mkdir -p "src/test/scala/$folderStructure/comet"
mkdir -p "src/test/scala/$folderStructure/snippet"
mkdir -p "src/test/scala/$folderStructure/model"
mkdir -p "src/test/scala/$folderStructure/util"

# Generate .keep files to upload file structure to Github w/o files
touch "src/main/scala/$folderStructure/snippet/.keep"
touch "src/main/scala/$folderStructure/model/.keep"
touch "src/main/scala/$folderStructure/comet/.keep"

touch "src/test/scala/$folderStructure/comet/.keep"
touch "src/test/scala/$folderStructure/snippet/.keep"
touch "src/test/scala/$folderStructure/model/.keep"
touch "src/test/scala/$folderStructure/util/.keep"

# Create empty files as placeholders
touch "src/main/webapp/index.html"
touch "src/main/webapp/static/index.html"
touch "src/test/resources/default.logback-test.xml"
touch "src/main/resources/props/default.props"
touch "src/main/webapp/templates-hidden/default.html"

# Load files with default values

if [ $buildFileChoice == 1 ]; then # 1 == build.sbt | 2 == build.scala
  cp "$startingFilesDir/build.sbt" "./build.sbt"
  buildFilePath="./build.sbt"
else 
  cp "$startingFilesDir/build.scala" "./project/build.scala"
  buildFilePath="./project/build.scala"
fi

cp "$startingFilesDir/plugins.sbt" "./project/plugins.sbt"
cp "$startingFilesDir/Boot.scala" $bootFilePath
cp "$startingFilesDir/Paths.scala" $pathsFilePath
cp "$startingFilesDir/default.logback.xml" "src/main/resources/default.logback.xml"
cp "$startingFilesDir/web.xml" "src/main/webapp/WEB-INF/web.xml"

#Replace values in created default files

build=$(sed \
  -e "s/\${appName}/$appName/" \
  -e "s/\${appVersion}/$appVersion/" \
  -e "s/\${organization}/$organization/" \
  -e "s/\${scalaVersion}/$scalaVersion/" \
  $buildFilePath)
echo "$build" > "$buildFilePath"

boot=$(sed -e "s/\${organization}/$organization/" $bootFilePath)
echo "$boot" > $bootFilePath

paths=$(sed -e "s/\${organization}/$organization/" $pathsFilePath)
echo "$paths" > $pathsFilePath


