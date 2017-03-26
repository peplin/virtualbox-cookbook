# changelog

## 2.0.3

* VirtualBox 5.1.18 as default
* Working test kitchen for Windows 2016 using publicly available Windows 2016
image from @mwrock's [mrock/packer-templates](https://github.com/mwrock/packer-templates). Others should be able to converge & verify for windows systems.
* Updating contact info in metadata 

## 2.0.1

* update to VirtualBox 5.1 and confirm it works for following in test kitchen
 * ubuntu-16.04, 16.10
 * centos 6.8, 7.2
 * debian 8.6
* convert to inspec tests to verify successful install in above environments

## 1.0.3
* update `yum` dependency to 3
