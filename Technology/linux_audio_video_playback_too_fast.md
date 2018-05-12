I just discovered an issue with audio/video playback (including during gaming): setting the audio output to HDMI speeds up the audio/video playback by 10%-20% (I'm guessing about the exact percent here as I didn't actually measure it. I'm just going by my ear).

Apparently this is due to changes in the Linux kernel related to Intel chipsets. The issue appears to be fixed in kernel 3.16, but that's not available yet in Ubuntu 14.04 (as of this post). To fix the timing issue, you can disable the new power features until 3.16 is available - or until Ubuntu 14.10 or possibly 14.04.2. Launch the command prompt and edit /etc/default/grub:

```shell
\$ sudo vim /etc/default/grub
```

Go to the line that contains "GRUB_CMDLINE_LINUX_DEFAULT". At the end you should see "quiet splash". Right after splash (include a space after splash) enter the following:

```shell
i915.disable_power_well=0
```

Your line should look something like this:

```shell
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash i915.disable_power_well=0"
```

Save the file and then run this command:

```shell
\$ sudo update-grub
```

Now reboot your machine. The "HDMI chipmunk" issue should be resolved. Audio/video should play back properly.
