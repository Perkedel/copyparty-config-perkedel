# Getting Started

Wanted to use this conf? Okay, here.

## Download!!!

Here repo:

https://github.com/Perkedel/copyparty-config-perkedel

```sh
# from your home folder (~),
mkdir -p ~/Serve/copyparty  # make this new directories e.g.,
cd ~/Serve  # go to this Serve Folder,
git clone https://github.com/Perkedel/copyparty-config-perkedel.git copyparty  # clone this repo onto /home/yourname/Serve/copyparty
```

## Setup account

> [!IMPORTANT]
> Do not share your account config! Make sure the following config is .gitignored.

Account is your secret. **Do not share**.  
create new file `/conf.d/account.conf`. That's account config, in this repo's `conf.d` folder.  
Add your username & the password for it. You can also add others

```conf
[account]
    edward: blablabla
    # user: pass
```

## Group

We recommend that you group the account so you can easily manage and shorten, who gets access to what.  
in the `/conf.d/groups.conf` you can see example of usernames being grouped to where.  
Now, add your own into one of these, or a certain new group.  
e.g., your company's be like

```conf
[groups]
    kaorfa: joelwindows7
    saorfa: edward, mukti, arn, yarn, tab
```

### (Bonus) Group Semantics

In Perkedel, we use special group name to denote the following

| group | translation |
| - | - |
| kaorfa | leader / admin |
| saorfa | moderator |
| family | internal, within biological DNA, adopted |

## Access config

Once you're done, check `accs` conf piece folder in `/conf_pieces`. Let's add your name or group into default files

e.g., in the `/conf_pieces/accs_default_noAccident.conf`, now with yours become

```conf
accs:
    rGh: *
    ar.Gwmh: @kaorfa
    rGwmh: @family, @saorfa
```

& so on, the without accident protections

```conf

accs:
    rGh: *
    ar.Gwmhd: @kaorfa
    rGwmh: @family, @saorfa
```

these here, will be implemented as one of the chosen flag under your volume accordingly.

## Begin copyparty with the presets

on `/conf` folder of this repository, there are serveral conf files you can choose.  
Select one of them according to your device configuration. If none of these according to your device, you can duplicate or make a new one of them, following the pattern of our config.  
Just make sure to add the `[global]`, `[account]`, & the rest of your volumes especially the root `[/]` with `/landing` or wherever, and other folders you'd like.

### Custom conf

> [!TIP]
> Copy this template!

e.g., you have config like

```conf
% ../conf_pieces/global_default.conf

[/]
    landing
    % ../conf_pieces/accs_readOnly.conf

[/kolmorotzzet]
    /media/joelwindows7/Kolmo_pool0
    % ../conf_pieces/accs_default_noAccident.conf

% ../conf.d
```

## Start copyparty now!

once done, go back to the root of this repository, coz it's best you start there.  
Now, start with your config you've designed or chose.

```sh
cd .. # go back to the root folder of this repository, then
./copyparty-sfx.py -c "conf/select-one-of-these-confs.conf"
```

> [!IMPORTANT]  
> Wait, stop, `ctrl+c`. **If you used plaintext password in your `/conf.d/account.conf`, watch for the generated hashed password above at your terminal**. Since our `/conf_pieces/global_default.conf` activated `argon2` pass hashing algorithm, copyparty will generate any occurence of plaintext password (one without preceeding `+`) with the new hashed one.  
> **copy that & replace each & every respective account password with newly generated one**.
> 
> **Always backup both plaintext & hashed password to your Password Manager of your favourite**. We currently use Bitwarden.
> 
> Now, Start again. Try login to your copyparty server any method, with your username & your saved password.