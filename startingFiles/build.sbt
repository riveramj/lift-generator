import sbt._
import Keys._
import com.earldouglas.xsbtwebplugin._

name := "${appName}"

version := "${appVersion}"

organization := "${organization}"

scalaVersion := "${scalaVersion}"

Seq(webSettings :_*)

resolvers ++= Seq(
  "snapshots" at "https://oss.sonatype.org/content/repositories/snapshots",
  "releases"  at "https://oss.sonatype.org/content/repositories/releases"
)

libraryDependencies ++= {
  val liftVersion = "3.0.1"
  Seq(
    "ch.qos.logback"      %  "logback-classic"    % "1.1.3",
    "org.eclipse.jetty"   %  "jetty-webapp"       % "9.2.13.v20150730" % "container; compile->default",
    "net.liftweb"         %% "lift-common"        % liftVersion % "compile",
    "net.liftweb"         %% "lift-webkit"        % liftVersion % "compile",
    "net.liftweb"         %% "lift-testkit"       % liftVersion % "test",
    "net.liftweb"         %% "lift-mapper"        % liftVersion % "compile"
  )
}
