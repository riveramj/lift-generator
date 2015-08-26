import sbt._
import Keys._
import com.earldouglas.xsbtwebplugin._

name := "${appName}"

version := "${appVersion}"

organization := "${organization}"

scalaVersion := "${scalaVersion}"

seq(webSettings :_*)

resolvers ++= Seq("snapshots" at "https://oss.sonatype.org/content/repositories/snapshots",
                  "releases"  at "https://oss.sonatype.org/content/repositories/releases"
              )

libraryDependencies ++= {
  val liftVersion = "2.6.2"
  Seq(
    "ch.qos.logback"         %  "logback-classic"        % "1.1.3",
    "org.eclipse.jetty"      %  "jetty-webapp"           % "9.2.10.v20150310" % "container; compile->default"
  )
}

/* streamlined generation of self serving embedded jetty jar */
resourceGenerators in Compile <+= (resourceManaged, baseDirectory) map
{ (managedBase, base) =>
  val webappBase = base / "src" / "main" / "webapp"
  for {
    (from, to) <- webappBase ** "*" x rebase(webappBase, managedBase /
      "main" / "webapp")
  } yield {
    Sync.copy(from, to)
    to
  }
}

parallelExecution in Test := false

// append -deprecation to the options passed to the Scala compiler
scalacOptions ++= Seq("-deprecation", "-feature")

scalacOptions in Test ++= Seq("-Yrangepos")
