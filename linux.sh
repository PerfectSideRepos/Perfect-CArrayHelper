tar czvf /tmp/carray.tgz Sources Tests Package.swift
scp /tmp/carray.tgz 192.168.56.11:/tmp
ssh 192.168.56.11 "cd /tmp;rm -rf carray;mkdir carray;cd carray;tar xzvf ../carray.tgz;swift build;swift test"
