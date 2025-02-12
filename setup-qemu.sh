
export PREFIX='/usr'

apt update -y 
&& apt upgrade -y
&& apt install qemu-kvm qemu-utils libvirt-daemon-system libvirt-clients bridge-utils virt-manager -y 
&& qemu-img create -f qcow2 vm-disk.qcow2 20G 
&& apt install wget 
&& cd ~ 
&& wget https://dl-cdn.alpinelinux.org/alpine/v3.21/releases/x86_64/alpine-virt-3.21.2-x86_64.iso 
&&  qemu-system-x86_64 \
    -hda vm-disk.qcow2 \
    -m 2000 \
    -smp 2 \
    -serial mon:stdio \
    -cdrom ~/alpine-virt-3.21.2-x86_64.iso \
    -netdev user,id=net0 -device e1000,netdev=net0 \
    -nographic \
    \
    -drive if=pflash,format=raw,read-only=on,file=$PREFIX/share/qemu/OVMF.fd \