# from xml.etree import ElementTree

from dataclasses import dataclass
from xml.dom.minidom import parseString
import requests


@dataclass
class Sitemap:
  """Represents a sitemap entry."""

  loc: str
  priority: float
  lastmod: str
  id: int

  # Constructor
  def __init__(self, loc: str, priority: float, lastmod: str):
    self.loc = loc
    self.priority = priority
    self.lastmod = lastmod
    self.id = int(loc.split("=")[1].split("/")[0])


# # <sitemapindex>
# # <sitemap>
# # <loc>
# # https://www.wowhead.com/cata/de/sitemap/guides?page=1
# # </loc>
# # </sitemap>
# # <sitemap>
# # <loc>
# # https://www.wowhead.com/cata/de/sitemap/news?page=1
# # </loc>
# # </sitemap>
# # </sitemapindex>
def get_sitemaps() -> list[str]:
  """Fetches and parses the sitemap from Wowhead."""
  # Fetch the sitemap XML
  response = requests.get("https://www.wowhead.com/sitemap")
  # Parse the XML
  parsed_data = parseString(response.text)
  all_urls = []
  # Extract the <loc> elements
  for sitemap in parsed_data.getElementsByTagName("sitemap"):
    loc = sitemap.getElementsByTagName("loc")[0].firstChild.nodeValue  # type: ignore
    all_urls.append(loc)

  return all_urls


def get_all_base_urls(version: str, idType: str) -> list[str]:
  """Fetches all URLs for a given version, and ID type."""
  all_urls = get_sitemaps()
  # Filter the URLs based on the provided parameters
  filtered_urls = [url for url in all_urls if f"/{version}/" in url and f"/{idType}?" in url]
  print(filtered_urls)
  return filtered_urls


# <urlset>
# <url>
# <loc>
# https://www.wowhead.com/cata/quest=1/kanrethads-quest
# </loc>
# <priority>0.1</priority>
# <lastmod>2010-04-21T16:49:25+00:00</lastmod>
# </url>
# <url>
# <loc>
# </loc>
# <priority>0.1</priority>
# <lastmod>2010-04-21T16:49:25+00:00</lastmod>
# </url>
# </urlset>
def get_specific_sitemap(url, locale=""):
  """Fetches and parses the sitemap from Wowhead."""
  if locale and locale != "en" and locale != "enUS" and locale != "":
    url = url.replace("sitemap", f"{locale}/sitemap")
  print(f"Fetching sitemap for {url}")
  # Fetch the sitemap XML
  response = requests.get(url)
  # Parse the XML
  parsed_data = parseString(response.text)
  all_urls: list[Sitemap] = []
  # Extract the <loc> elements
  for sitemap in parsed_data.getElementsByTagName("url"):
    loc = sitemap.getElementsByTagName("loc")[0].firstChild.nodeValue  # type: ignore
    priority = sitemap.getElementsByTagName("priority")[0].firstChild.nodeValue  # type: ignore
    lastmod = sitemap.getElementsByTagName("lastmod")[0].firstChild.nodeValue  # type: ignore

    sitemap_entry = Sitemap(loc=loc, priority=float(priority), lastmod=lastmod)
    all_urls.append(sitemap_entry)

  return all_urls


def get_all_sites(version: str, idType: str) -> list[Sitemap]:
  all_sites: list[Sitemap] = []
  urls = get_all_base_urls(version, idType)
  for url in urls:
    data = get_specific_sitemap(url)
    all_sites.extend(data)

  return all_sites


def get_all_ids(version: str, idType: str):
  sites = get_all_sites(version, idType)
  all_ids = []
  for site in sites:
    all_ids.append(site.id)
  return all_ids


# with open("sitemaps.txt", "w", encoding="utf-8") as f:
#   sites = get_all_sites("cata", "item")
#   for site in sites:
#     f.write(f"{site.id}\n")

# print(i)
# for version in dataEnvLookup.keys():
#   for idType in allowedTypes:
#     # Get all URLs for the given locale, version, and ID type
#     urls = get_all_base_urls(version, idType)
#     for url in urls:
#       data = get_specific_sitemap(url)
#       for sitemap in data:
#         # loc https://www.wowhead.com/cata/item=25/worn-shortsword
#         extractedId = sitemap.loc.split("=")[1].split("/")[0]
#         print(extractedId)
#         exit(0)

# Write the URLs to the file
# for url in urls:
#   for locale in localeToURLLocale.values():
#     data = get_specific_sitemap(url, locale)
#     f.write(url + "\n")
#     print(url)
#       # Get all URLs for the given locale, version, and ID type
#       urls = get_all_urls(locale, env, idType)
#       # Write the URLs to the file
#       for url in urls:
#         f.write(url + "\n")
#         print(url)

# for url in get_all_base_urls("cata", "quest"):
#   get_specific_sitemap(url, "de")
#   f.write(url + "\n")
