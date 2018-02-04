package ${organization}.util

import net.liftweb.sitemap._

object Paths {
  val homePage = Menu.i("Home") / "index"

  def siteMap = SiteMap(
    homePage
  )
}
