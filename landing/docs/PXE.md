# PXE Boot

In theory, you can make Copyparty holds the file itself for the network booting. Simply have a DHCP Server that supports advanced bells & whistles that pertains to this, namely `next-server`, along with what `filename` should go to when PXE booter told to this server, which is your copyparty server IP address.

The protocol for your copyparty that you must enable is Trivial File Transfer Protocl (TFTP), at a standard port of **`69` nice**.

```conf
#blo blo blo
[global]
    # bla bla bla
    tftp: 69  # oh, trivial ftp too! `: 3969`? nah.. standard port instead!
    # bla bla bla
#blu blu blu
```

> [TIP]  
> To comment on copyparty config inline after a parameter, make sure **to add 2 spaces before the `#` commment**.

If your existing DHCP server has *go to this TFTP server pls* capability, then you're in luck. Otherwise, you're out of luck. Idk how to get dedicated DHCP server only to cater this PXE offering just to get it done. Though there are few options you can try:

## [Netboot.xyz](https://netboot.xyz)

Netboot.xyz is the brand new [iPXE](https://ipxe.org/) kit, that has their own included ready-to-boot menu server. Context, the iPXE lets you build *website*, for your BIOS, which is what you fill your TFTP server with. There are the index, which is your `ipxe.pxe` executable, and the `menu.ipxe` which is the iPXE app run when you are already at the iPXE *OS*. The rest of the files can be filled with whatever stuffs you want, and the `menu.ipxe` contains the selectable list pointing to each of the file.

If you wish to no bother of all this currently niche hence complicated stuff, you can just use whichever version of the netboot.xyz pre-packaged iPXE kit binary (e.g., use the Universal ISO version). The binary once you've reached the iPXE OS, it'll like usual, ask DHCP (broadcast) somewhere who knows (or you can manually configure IP Address, Gateway where your router is, Subnet, & DNS, if somehow the DHCP you have succ) to get network config, **& automatically try to either go to their boot website ([https://boot.netboot.xyz](https://boot.netboot.xyz)) (Pre-packaged kit) or whatever `menu.ipxe` you have filled with next by the iPXE OS binary (`kpxe` version). Once everything success, you'll be presented their boot market menu, for which you can now choose whatever OS you want to try, debug whatever, or skip to boot to some local disks you got.

![Netboot in action](https://netboot.xyz/assets/images/netboot.xyz-d976acd5e46c61339230d38e767fbdc2.gif)

If you want to *hopefully-easily* setup your own netboot.xyz, netboot.xyz also has [their own prepared Docker Container](https://netboot.xyz/docs/docker/) you can also use. The image is available by pulling from their GitHub `ghcr.io/netbootxyz/netbootxyz` (e.g. use `docker pull ghcr.io/netbootxyz/netbootxyz` command). It includes DHCP, TFTP, HTML (to config UI) server.

## manually dnsmasq the shit

Since your router succ & does not have the capability you want, Linux **(unfortunately only)** has currently the best you can use DHCP server daemon called `dnsmasq`. It is very mainstream & should be available to install from your favourite package manager.

[Still on the netboot.xyz](https://netboot.xyz/docs/docker/dhcp), you can setup the parameters to point any PXE offer request to whatever netboot.xyz binary that matches whatever architecture of whom asked from. The dnsmasq as you can see have those if else features that allows you to scan their architecture & provide matching file they can boot from. Then all these if elses, you can point it to your copyparty tftp enabled server. Now, just fill its root directory with all binaries according to your if else architectures you fill with. It is also best to **make sure you have only 1** DHCP server in the network, to make sure their pre-boot network dynamic configuring works best properly, because your dnsmasq DHCP daemon will also acts as a regular DHCP that gives IP Addresses. Idk how to make it only give PXE & throw IP request back to existing DHCP yet.

Again, now you need to fill in your TFTP content with the boot market website complete with the assets like the netboot.xyz does. Or maybe let the netboot.xyz itself go straight to the internet & pull their official boot website instead since now you have the completed network configuration.

## [Tiny PXE Server](https://github.com/erwan2212/tinypxeserver) (**NOT RECOMMENDED**)

Did not time or guts enough to inul Linux but can't help to try PXEing? You can use this software. Just download the file `pxeserv.zip` that contains all you need. The server app has GUI included. Tiny PXE Server comes with DHCP, TFTP, & all other kinds of protocol supports for various kinds of Network Booting. Powered by iPXE, the boot website is already pre-configured. You just need to fill out the boot disks according to what's available here. Windows, Linux, & UNices UNIX, put them all to respective directories.

Despite this tho, we do not recommend using it in a professional environment anymore, **since this software is proprietary**, as well as not available for Linux & Unices, & being no longer update long since. Since I assume you understand how to build PXE server (DHCP with `next-server` & `filename`, & this copyparty TFTP), you can instead use above latest & greatest netboot.xyz. Again unfortunately, there is no Easy-no-web UI like this option. If you have found GUI to netboot.xyz that is not HTML based (not even say Tauri since that's still HTML), let us know.

## [iVentoy](https://iventoy.com) (**NOT RECOMMENDED**)

if doing iPXE somehow feels undesirable, you can setup another all in one kit with **iVentoy**, from the same guy who made [Ventoy the USB format-once forever booter](https://ventoy.net). It comes with DCHP, & TFTP with the boot website included. Simply fill out whatever boot disk you want in its `iso` directory next by the daemon app, run, go to config, and start the PXE. Easy and ready to go.

You can also disable the PXE & only have the TFTP server. Now, you can tell your DCHP `next-server` to lead to your iVentoy TFTP server, and fill `filename` with e.g. `iventoy_loader_16000` (`External` mode) or manually `iventoy_loader_16000_bios` (`ExternalNet` mode with dnsmasq matching architecture `bios`) & `iventoy_loader_16000_efi` (dsnmasq matching architecture `efi`), etc etc.

Gravely enough, unlike Ventoy, **iVentoy is proprietary & paywalled (Partialism)**. Free version can only accept limited numbers of connection & blocks `ARM64` devices. Payment for it is available through dev's local payment method (Alipay & WePay) & Paypal. License file works by binding a unique ID (`Machine Code`), and just work for that ID.

Additionally, its built-in DHCP configuration is rather limited, and you cannot change the TFTP port (if somehow your device supports that or to move aside off of your available TFTP instance in the same server computer). Therefore we recommend to just use External DHCP mode, & a better DHCP server that allows you to `next-server` into your iVentoy TFTP. If you also want to have different port of TFTP like you can with this copyparty (& know how to port forward whatever `69` or what this is), you may ditch this altogether. 

## Problem

### [Oracle Virtualbox](https://www.virtualbox.org/)

Despite Virtualbox ships with that iPXE, unfortunately, the ROM that's included strips too many of the essential features, especially `http`, `https`, and rest others iPXE could've had. e.g., you want PXE go to the internet to go to https://boot.netboot.xyz ?, then you need `HTTPS`, or else you can only local. Therefore your boot app format option is severely limited.  
Well then, fuck this shit, maybe you can just use Netboot.xyz kit instead already, since they crippled the built-in one. Don't tell me to *flash a new ROM* to it, too complicated!

### Fail to DHCP config somehow despite everything else works normally

Your DHCP succ!! do not use ISP provided router to get it done! Buy new router! **Do not cheap out**, use the best of the best such as [Ubiquiti](https://ui.com/us/en/cloud-gateways/wifi-integrated). This definitely has the dedicated network boot stuff in the DCHP option. the `next-server` to fill your copyparty tftp server with & `filename` to fill what PXE app to run on that server.

Or again, use dnsmasq and do above configs if you have dedicated server for it.

## Why the fuck we want PXE after all? Not only niche, it's fucking complicated, can fails often and makes all my hair folicles decay much quicker!

We indeed do not need to go into trouble at all to PXE just to get your computer running. You can just use local boot disk that you want, & call it a day. But in the multi-computers world, doing local one by one is **HELL ON EARTH!!** Therefore, PXE is the soluition to configure those so many computers without having to plug USB disks one by one, PC to PC. Just deploy one PXE server for the network, and all computers connected to the network with the specially configured DHCP `next-server` offerings will receive the gift needed to either install or e.g. boot a thin client OS that does VNC to the real PC somewhere in the different room remotely.

In theory, best DCHP & best TFTP system will works. We now been knowing all we need to know: `dnsmasq` or Best Router Ubiquiti as the DCHP server, & `copyparty` for the TFTP. DCHP fill the `next-server` to IP Address of your `copyparty` server computer, & fill `filename` with whatever PXE OS filename you want. Very easy. And as long as your PXE ROM in each & every PC is standard & compliant, then it should be able to ask IP Address who knows, then run the PXE OS once they received the gift needed (IP Address, the TFTP adress for which file you have to go to).

Alternatively, you can flash the ROM disk of your computer with that `netboot.xyz` so it only runs best of the best possible iPXE once you turn on the unit, disregarding the built-in PXE (who knows succ), & fetch whatever OS can be used. This way, if your TFTP for the specific use case OS is down, then your clients should atleast still be usable & let you browse netboot boot website instead. Even if the DHCP also is down, its failsafe menu (`hit m for failsafe menu`) allows you to manually configure IP Address, Subnet, Router Gateway where connect to, & DNS, so you can atleast try to recover something. Like... [System Rescue](https://www.system-rescue.org/), then SSH to your systems & fix what the hel is going on.