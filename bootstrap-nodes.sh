#!/usr/bin/env bash

# This is just a Proof of Concept, don't put passwords or ssh-keys on github :)

cat <<EndOfKey >> /home/vagrant/.ssh/authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDP/m1m5QSxyL8i2qEHdLIMjUt8ZRUtkPdajVCdKsU3vuGRTYQg/ndmm/vEDk/CB2lh50ZaxXMt783ulKtQH37ogy1QxGOn8eIgkcQ7qwGihop0q/Gzx8joDmtNxch+BZrXeyPn2VPFVLDx2ZkauitWTHzCcfswnpUBk7kHyyrSCCAhPVNHq5UQ4NwjsYtFDUWYRF8cTbi7lWgBdYyJZ1+NhJWwY63E8pMEPC6GxdChevEUXEoMWYdlZwAybRlrcDZmFuQ3RGjAZuIy2XGbx5gm9svQw8Or74Ui+Is2VzKX65cI4zi3RhRTkzhDhaJIFjFZ1zgSQP74LVOTJkyR2f1x ansible@poc
EndOfKey

