# noc_modified 
author: `scriabing` 
feedback : `zhuyingxuan@iie.ac.cn`

* modify the noc module of NVDLA by adding  more read and write ports

* verify the module with tb file and axi slaver


ps:
If you want to verify the origin noc from nvdla/hw , please commend out the CH7_rd&CH3_wr in tasks.vh  and modify the module port in tb.
