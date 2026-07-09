
# Fullpage HTML5 Lightroom Web Gallery

> *This readme is about usage. For more general info, see [the website](https://jtbr.github.io/FullpageAlbum.lrwebengine/)*

Thanks for downloading the Fullpage Web Album Plugin for Adobe Lightroom! Hope you enjoy it.

Fullpage is a responsive, single-page scrolling web photo gallery. Images are laid out down
a single page and lazy-loaded as you scroll, and clicking an image opens it in a full-screen
[PhotoSwipe](https://photoswipe.com/) viewer with swipe, zoom, and an optional slideshow.

### Installation:

1) Unzip the `FullpageAlbum.lrwebengine` folder and copy this to the Lightroom `Web Galleries` folder. This folder can be opened within Lightroom preferences (Win: *Edit->Preferences*, Mac: *Lightroom->Preferences*) by clicking on the "Show Lightroom Presets Folder" button, then opening `Web Galleries`.
	* On *Mac* this is located under: `/Users/username/Library/Application Support/Adobe/Lightroom/Web Galleries/`
	* On *Windows Vista/7/8/10*, this is normally under: `C:\Users\username\AppData\Roaming\Adobe\Lightroom\Web Galleries\`
	* On *Windows XP* this is normally under: `C:\Documents and Settings\username\Application Data\Adobe\Lightroom\Web Galleries\`
1) (Re-)Start Lightroom; the Fullpage gallery should appear in the list at the top right under the Web workflow

The gallery works out of the box with sensible defaults — no presets are required. Once you've set up an album you like, you can save your own template ("skin") from within Lightroom's Web module to reuse those settings.

### Usage:

* As with any web album, select the images you wish to export using the **Library** view in Lightroom. Be sure they have all the metadata you want to include in the album. When you're happy with the images and their order, open the **Web** view.
* Select the `Fullpage HTML5 Gallery` from the Layout style at the top right.
* In the Web view, choose the options you want. Enter titles, descriptions, customize your image captions and use a custom logo, and choose where they appear. Customize your color scheme and how images will appear. Choose the size of the on-page image and the larger expanded image generated for the full-screen viewer, as well as caption metadata and watermark to include. You can use the **Preview in Browser** button to check out your album's appearance. And then simply **Export to disk** or **Upload** (to a server via FTP/SFTP) the complete album when you're ready! The resulting HTML pages and supporting files will be generated in the folder or server location you selected. 
	* You can view them on your local computer by opening the file `index.html` in a web browser. The generated folder can then be loaded onto a web server for access via the web or just copied to a CD/DVD or shared folder to share with others.
* [More details about creating web albums in general are available from Adobe](https://helpx.adobe.com/lightroom/help/creating-web-galleries-basic-workflow.html).

### Tips and configuration options:

* Most but not all of the options are reflected in the preview within Lightroom. *Only a limited number of images are generated for previews within Lightroom*, to prevent previews from taking too long to generate.

* When you change many of the configuration options, the preview within Lightroom does not refresh automatically. To force it to update, toggle a setting that Lightroom always re-renders for — for example, switch the watermark option on or off, or change the selection of images.

* If serving the gallery from a web server, it is strongly recommended to use gzip compression on the server serving these pages. Fullpage has been optimized with this in mind. See [here](http://betterexplained.com/articles/how-to-optimize-your-site-with-gzip-compression/) for more info. The included `res/deploy_to_s3` script (see below) handles this automatically when deploying to Amazon S3.

* There are two image sizes: the medium image shown inline on the page, and a larger expanded image loaded into the full-screen viewer when an image is opened. For normal screens, the default medium size is a good balance, but if you'll have a lot of viewers with high resolution or "Retina" style screens (where each logical pixel is more than one actual pixel), then it makes sense to use higher values. Since images are never scaled up, this ensures they will be large enough to fill the screen, and on retina displays they'll look crisper. The downside is that larger images are slower to load and take up more bandwidth, so are worse especially where broadband is unavailable. 

* In some cases the album is represented by an image in social media, and this image is specified by the index value, which is 1-based count starting from the beginning of the album.

* The "Destination URL path to gallery" is the preferred, canonical URL path to the intended final location of the gallery on the web. This path will contain the gallery's index.html file and im/ and res/ directories. It is used for social media and search engines, to generate previews and consolidate the various ways that a page might be accessed. For these functions to work correctly, it's important that the path not redirect somewhere else. 

* The markup option allows you to include arbitrary invisible markup in the head of the generated web album. It can be useful for including web fonts, web analytics, etc. Note that it must be valid HTML. 

* The font family stacks are ordered lists (preferred to less-preferred) and can include web fonts (such as [these from Google](https://www.google.com/fonts)) if you have included markup for them above, for example: 
   ```html
   <link rel="stylesheet" type="text/css" href="http://fonts.googleapis.com/css?family=Tangerine">
   ```
	[Here are some tips for choosing font stacks.](https://www.smashingmagazine.com/2009/09/complete-guide-to-css-font-stacks/)

* Links to a map are available for any image with a GPS location, or any image with a City and either a State or a Country. If both GPS locations and cities are selected and an image has both, then the GPS location will be used. If the city is used, a combination of all available sublocation, city, state, and country fields will be used for geolocation.

* All the strings that are used in the generated web album (e.g. *Next Photo*, *Play Slideshow*, ...) are customizable. They are found in the `TranslatedStrings.txt` file in the `strings/en` subdirectory. The relevant strings are below the line `--[[Custom strings]]`.


#### For more information and updates, please visit [the Fullpage home page](https://jtbr.github.io/FullpageAlbum.lrwebengine).
