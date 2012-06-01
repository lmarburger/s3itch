S3itch - Sharing Skitch uploads on ~~S3~~ CloudApp
======

As Skitch will soon shut down their own hosting and [switch to
Evernote](http://blog.evernote.com/2012/03/19/skitch-for-mac-gets-sharing-through-evernote/),
the only reasonable solution is to use WebDAV and share files with ~~S3~~
[CloudApp][cloudapp].

[cloudapp]: http://getcloudapp.com

Installation
============

This is still bleeding edge. Bumpy road ahead.

1. Get your CloudApp API token

   ```bash
   curl -H "Content-Type: application/json; charset=utf-8" \
         -X POST \
         -d '{ "email": "EMAIL", "password": "PASSWORD" }' \
         "http://api.getcloudapp.com/account/token"
   ```

   Don't bother groking the returned JSON. Just look at the very last quoted
   string.

2. Open the Skitch preferences, select the Share tab, and create a new account.
   Choose WebDAV as the account type.

   ![](http://cl.ly/0M38323R1k0q2F0y3Y1E/content)

3. Set the following options:

   * **Server**: skitch.cl.ly
   * **Password**: Your API token from step #1
   * **Base URL**: http://skitch.cl.ly/check

   ![](http://cl.ly/0n3X1j3A1B0C2A3l092y/content)

4. Flip back over to Skitch and it's business as usual except clicking _Share_
   at the bottom of the window will upload to CloudApp!

   ![](http://cl.ly/0o2f0q052g2l3c0a010U/content)

5. This step is optional but to get the most out of this integration, you'll
   want to run the following command to have the CloudApp Mac app automatically
   copy the drop's link when it's uploaded. I don't think it's possible for
   Skitch to copy the correct CloudApp share link, but it's still up in the air.

   ```bash
   defaults write com.linebreak.CloudAppMacOSX CLUploadShouldCopyExternallyUploadedItems -bool YES
   ```

   If you're running the stand-alone version of the CloudApp Mac app, you'll
   have to use a different plist:

   ```bash
   defaults write com.linebreak.CloudAppMacOSXSparkle CLUploadShouldCopyExternallyUploadedItems -bool YES
   ```

   To disable this option in the future, run the same command but replace
   **YES** with **NO**.


Acknowledgements
================

This integration is possible thank's to [Mathias Meyer's s3itch](s3itch) which
adds uploading to an S3 bucket to Skitch. Special thanks to
[Eric Lindvall][eric] for encouragement and enlightenment.

[s3itch]: https://github.com/mattmatt/s3itch
[eric]:   https://github.com/eric
