# Liftweb Generator 

Lift projects require a number of folders and files for a basic project. This generator will ask some basic questions and then create a skeleton structure to help speed up the setup process.

Issues / Pull Requests welcome.

####Questions it asks

1. **Enter the path for the new lift project [/amazing/new/app/path]**
  1. *Path will be verified and prompt if it should be created*
1. **what is the app name:**
1. **what is the app organization [com.example]:**
1. **what is the starting version [0.1-SNAPSHOT]:**
1. **what scala version do you want to use [2.11.7]:**
1. **Choose a build file to use.**
  1. [1] build.sbt 
  1. [2] build.scala

It’ll create the following files with values:
* build.sbt/build.scala
* plugins.sbt
* Boot.scala
* Paths.scala
* default.logback.xml

Additionally it'll create some blank placeholder files:
* src/main/webapp/index.html
* src/main/webapp/static/index.html
* src/test/resources/default.logback-test.xml
* src/main/resources/props/default.props
* src/main/webapp/templates-hidden/default.html

it also creates the following structure:
* project/
* src/main/scala/bootstrap/liftweb/
* src/main/scala/$folderStructure/util/
* src/main/scala/$folderStructure/snippet/
* src/main/scala/$folderStructure/model/
* src/main/scala/$folderStructure/comet/
* src/main/resources/props/
* src/main/webapp/WEB-INF/
* src/main/webapp/templates-hidden/
* src/main/webapp/static
* src/main/webapp/images

and the test structure:
* src/test/scala/$folderStructure/util/
* src/test/scala/$folderStructure/snippet/
* src/test/scala/$folderStructure/model/
* src/test/scala/$folderStructure/comet/ 
