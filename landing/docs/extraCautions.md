# Extra Cautions

There are more cautions that you must abide here to ensure no 3rd parties felt disrupted when doing copyparty.

## Facing it Online Publicly

### Be careful, if your Download place may have contained

- items you bought or sparsdated
- items your customer / client have commissioned you for, in which on some point of agreement either or both shall not be shared for anyone else, or cannot be shared before it is finished

### You can apply some following tricks:

#### Dot File Hidings

append `.` (dot) by the beginning of the folder name for those files that contains it. Then prevent non-logged in users from accessing `.` files by making sure `.` accs absent for `*` (all user)

```conf
[/DownloadsLinksInDescription]
    /media/john/Pool0/PublicFile
    acss:
        rGh: *  # all non-logged in user can read files, but not `.` started folders
        A.a: @admin  # only the admin gets to see `.` files. Maybe you can just also remove the `.` permission on the left if you don't intend using external players & only enjoy from this same computer. 
```

Say, if you have a paywalled files, just put those organizedly right in any folder that has been dotted, such as `.PAID`. Anywhere in the directory, nobody will able to see `.PAID` folder at all, even when `Show Hidden` is ON. Same goes for `.TOP_SECRET`, `.Investigation`, `.Evidence`, etc. & so on.

Pls request feature to hide anything that folder name match regex.