 This script is designed to be placed in a folder with lots of images and videos including subfolders, create thumbnails of all the images found and uses ffmpeg to create frame sheets for movies then add 100 per HTML page with a "Next" link at the bottom linking to the next gallery page.

Make sure to adjust the settings in the config section to suit your needs.


Prerequisites
Download ffmpeg from https://ffmpeg.org/download.html#build-windows, unzip and copy the contents to c:\ffmpeg
Add the ffmpeg folder as a path, as per below.


Download and install ImageMagick and ensure the "add to systm path" is ticked during the installation. https://imagemagick.org/index.php

Place your images, videos in "Files" directory

ffmpeg seems to have issues with certain special characters so ensure there aren't any in the video filenames

See screenshots for examples.

<img width="640" height="367" alt="image" src="https://github.com/user-attachments/assets/e5705047-6a8c-449d-8fa7-afd5c729905d" />


<img width="640" height="465" alt="image (1)" src="https://github.com/user-attachments/assets/87b29239-9425-4db4-9382-5061cc8bd9e7" />


<img width="638" height="272" alt="image (2)" src="https://github.com/user-attachments/assets/6115b1fb-de45-431d-9ba3-f14e4ec42d86" />



