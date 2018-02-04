import sbt._
import Keys._

name := "${appName}"

version := "${appVersion}"

organization := "${organization}"

scalaVersion := "${scalaVersion}"

enablePlugins(JettyPlugin)

resolvers ++= Seq(
  "snapshots" at "https://oss.sonatype.org/content/repositories/snapshots",
  "releases"  at "https://oss.sonatype.org/content/repositories/releases"
)

libraryDependencies ++= {
  val liftVersion = "${liftVersion}"
  Seq(
    "ch.qos.logback"      %  "logback-classic"    % "${logbackVersion}",
    "org.eclipse.jetty"   %  "jetty-webapp"       % "${jettyVersion}" % "container; compile->default",
    "net.liftweb"         %% "lift-common"        % liftVersion % "compile",
    "net.liftweb"         %% "lift-webkit"        % liftVersion % "compile",
    "net.liftweb"         %% "lift-testkit"       % liftVersion % "test",
    "net.liftweb"         %% "lift-mapper"        % liftVersion % "compile"
  )
}
