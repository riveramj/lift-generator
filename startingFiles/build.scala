import sbt._
import Keys._
import com.earldouglas.xsbtwebplugin._

object Build extends Build {

  lazy val project = Project("root", file(".")).settings(
    name := "${appName}",
    organization := "${organization}",
    version := "${appVersion}",
    scalaVersion := "${scalaVersion}",

    resolvers ++= Seq(
      "snapshots" at "https://oss.sonatype.org/content/repositories/snapshots",
      "releases"  at "https://oss.sonatype.org/content/repositories/releases"
    ),

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
    },
    WebPlugin.webSettings
  )
}
