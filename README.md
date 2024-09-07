# xmrig
[![AGPL License](https://img.shields.io/badge/license-AGPL-blue.svg)](https://www.gnu.org/licenses/agpl-3.0.html)
[![CI](https://github.com/comminutus/xmrig/actions/workflows/ci.yaml/badge.svg)](https://github.com/comminutus/xmrig/actions/workflows/ci.yaml)
[![GitHub release (latest by date)](https://img.shields.io/github/v/release/comminutus/xmrig)](https://github.com/comminutus/xmrig/releases/latest)


## Description
This is an [XMRig](https://github.com/xmrig/xmrig) container image.  There are two images to choose from.  Both images use [Chainguard](https://www.chainguard.dev) base images. Chainguard images are distroless, and as such has very little attack surfaces.  

## Getting Started
```
podman pull ghcr.io/comminutus/xmrig
podman run -it --rm ghcr.io/comminutus/xmrig
```

## Usage

There are two distributions, and thus two tags you can use:

### vanilla ###
In the `vanilla` image, the `xmrig` binary comes directly from the [XMRig](https://github.com/xmrig/xmrig) team's releases. It is cryptographically verified to ensure the distribution package is sound.  To use this image, pull any of the container images using the `vanilla` tag.  This is also the default, so `latest` will default to the latest `vanilla` release.

Because the vanilla image uses [Chainguard's static image](https://images.chainguard.dev/directory/image/static/versions) as a base image and runs as non-root, the [MSR mod](https://xmrig.com/docs/miner/randomx-optimization-guide/msr) cannot be applied for more efficient mining.  If you want to use the MSR mod and run `xmrig` as root, use the `msr` tag below.

The `vanilla` image has no shell, which means you cannot execute a shell into the container.

### msr ###
In the `msr` image, the `xmrig` binary is compiled from source as a static binary. The [automatic 1% donation](https://xmrig.com/docs/miner/config/network#donate-level) is also removed, which means by default the donation level is set to 0%.  If you'd like to set a higher donation level, you can configure it in the configuration file (see below) or use the [`--donate-level` switch](https://xmrig.com/docs/miner/config/network#donate-level).

In order for the MSR mod to be applied successfully, you need to run this container image as root with extended privileges (using `--privileged` in Docker or Podman).

Because this image requires running a script to apply the MSR mod, it uses [Chainguard's busybox image](https://images.chainguard.dev/directory/image/busybox/versions) as a base image. Therefore, the attack surface from a cybersecurity perspective is higher than the `vanilla` image.


### Configuration and Options
The container image does not set any command line options by default to the `xmrig` binary. For a full list of command line options, consult the [XMRig documentation](https://xmrig.com/docs/miner/command-line-options).

A JSON config file is the preferred way to configure XMRig. The command line interface does not cover all features, such as mining profiles for different algorithms. Consult the [XMRig Config File documentation](https://xmrig.com/docs/miner/config) for more details on how to setup a configuration file. 

You can mount this configuration file at `/home/nonroot/.config/xmrig.json` for the `vanilla` image and `/root/.config/xmrig.json` for the `msr` image without having to set the path to the configuration file with `-c` or `--config=FILE`.

### User/Group
The container runs as `nonroot` with group `nonroot` (uid: 65532, gid: 65532) in the `vanilla` image and as `root` in the `msr` image. 

## Common Issues
- `FAILED TO APPLY MSR MOD, HASHRATE WILL BE LOW`
    In order to take advantage of the MSR MOD, you must use a _rootful_ (i.e. `root` user) _privileged_ container (`sudo podman run --privileged`, etc.) and be using the `msr` image.

## Dependencies
| Name                                         | Version   |
| -------------------------------------------- | --------- |
| [xmrig](https://github.com/xmrig/xmrig)      | v6.22.0  |
| [Chainguard static](https://images.chainguard.dev/directory/image/static/versions) | latest |
| [Chainguard busybox](https://images.chainguard.dev/directory/image/busybox/versions) | latest |



## License
This project is licensed under the GNU Affero General Public License v3.0 - see the [LICENSE](LICENSE) file for details.

This container image includes XMRig's license as well, which is distributed under
the terms of the GNU General Public License version 3 (GPLv3). The corresponding source code can be obtained
[here](https://github.com/xmrig/xmrig).
