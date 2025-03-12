# Oracle-Linux-9.5-Image-on-Openstack-Cloud
This repo is to create Oracle Linux 9.5 image for use with Openstack Cloud

For oracle Linux Cloud base image : https://yum.oracle.com/templates/OracleLinux/OL9/u5/x86_64/OL9U5_x86_64-kvm-b253.qcow2

For ubuntu cloud base image from below: https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64-disk-kvm.img 

Format should be img and compatible with qemu/kvm.QCow2 UEFI/GPT Bootable disk image with linux-kvm KVM optimised kernel. 

Method 1:

Upload the base image to openstack image service via GUI or you can use openstack image create command to upload the image (as qcow2) to your project and then copy the UUID which will be used inside the packer HCL 

openstack image create "OracleLinux9.5" --file oracle-linux.qcow2 --disk-format qcow2 --container-format bare —private

You can use this image UUID as source_image for the packer template.

Method: 2

There is another way in which you can provide the source base image URL instead of creating/uploading the image to openstack . 

Use the base url of the image like : https://yum.oracle.com/templates/OracleLinux/OL9/u5/x86_64/OL9U5_x86_64-kvm-b253.qcow2 

In this method packer create an temporary image using external source image with name packer_<uuid> on openstack temporarily. 
Create server with this image and ssh to the server to make changes like cloud-config. 
Once changes made then stop the server and create image from that server instance. Finally delete the temporary packer image from openstack cloud. 


