Save MPG streams of a Movie DVDs
================================

This is a quick and dirty far from perfect script to playback all the different MPG streams of a video DVD to harddrive.


Usage:
------

```
cd
sudo apt-get install libdvdread-dev
git clone https://github.com/hilbix/libdvdread-samples
cd libdvdread-samples
make
sudo make install

cd
git clone https://github.com/hilbix/dvd-read
cd dvd-read
./read.sh /dev/dvd
```


Advantages:
-----------

- Creates MPG streams which most movie players can playback.  You can even playback the movie while it is extracted, however you have to open the `*.tmp` file then.

- This script is completely legal!  There is nothing to it which can be illegal.  It does not circumvent any copy protection.  It does not contain any CSS decrypting code.  All it does is to access some stone old standard scripts which playback the movie.  The rest is handled by your sysstem standard libraries.  So if this script is illegal, your Linux install is illegal, too.

- If the DVD is defective, aka. has a stuctural protection (thought to make it difficult to copy the DVD), this script usually has no problem to extract the movie, because the movie still must be playable, and this is exactly what this script does:  Playback the movie right to harddrive.  If this still has a problem, the same problem will be with any other PC based movie player, so the DVD is seriously broken and many DVD players will be unable to play this DVD.


Bugs:
-----

- You need 8 GB free harddrive space, or even more (when angles are present), because this does no transcoding.  It just writes the "raw" MPG streams to your drive.

- It is not able to decrypt CSS if libdvdcss2 is not installed.

- This script looses all menu navigation structure and other DVD features which are not MPG streams.  So it cannot be used to backup a DVD.

- Menus are only extracted as MPG streams.  This, however, gives you the advantage to directly jump to the main movie or discover some "hidden" feature film sequences on the DVD easily.

- The error reporting is not implemented.  Just a logfile is written.  If something goes wrong, you will see it in the `*.log` file which is named after the corresponding `*.mpg` file.  First have a look at the last line of the log `tail -1 */*.log`.  Sometimes (CSS problems) are reported above.  This bug probably will never be fixed.

- There might be serious errors before the main movie, in that case the read errors must be skipped first.  If this takes all too long, you perhaps want to do extraction yourself.  Look in the script, using `play_title` really is easy.

- The script should be able to extract all angles, but I am not aware of any DVD I own using that feature, so I was not able to test this feature yet.

- If the script extracts different angles, this probably means, that you extract an MPG streams several times (one time for each angle again).  Please expect a lot more data and a lot more extraction time in that case.  This is not really a bug of this script, it is a bug of the method used to extract the data.


License
-------

This Works is placed under the terms of the Copyright Less License,
see file COPYRIGHT.CLL.  USE AT OWN RISK, ABSOLUTELY NO WARRANTY.

