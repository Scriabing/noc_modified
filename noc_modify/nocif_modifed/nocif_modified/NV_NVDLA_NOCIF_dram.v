`define VLIB_BYPASS_POWER_CG
`define NV_FPGA_FIFOGEN
`define FIFOGEN_MASTER_CLK_GATING_DISABLED
`define FPGA
`define SYNTHESIS

// ================================================================
// NVDLA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_NOCIF_dram.v
// ================================================================
// NVDLA Open Source Project
// 
// Copyright(c) 2016 - 2017 NVIDIA Corporation.  Licensed under the
// NVDLA Open Hardware License; Check "LICENSE" which comes with 
// this distribution for more information.
// ================================================================
// File Name: NV_NVDLA_define.h
///////////////////////////////////////////////////
//
module NV_NVDLA_NOCIF_dram (
   nvdla_core_clk
  ,nvdla_core_rstn
  ,pwrbus_ram_pd
  ,client02mcif_rd_cdt_lat_fifo_pop
  ,client02mcif_rd_req_valid
  ,client02mcif_rd_req_pd
  ,client02mcif_rd_req_ready
  ,client02mcif_rd_axid
  ,mcif2client0_rd_rsp_valid
  ,mcif2client0_rd_rsp_ready
  ,mcif2client0_rd_rsp_pd
  ,client02mcif_lat_fifo_depth
  ,client12mcif_rd_cdt_lat_fifo_pop
  ,client12mcif_rd_req_valid
  ,client12mcif_rd_req_pd
  ,client12mcif_rd_req_ready
  ,client12mcif_rd_axid
  ,mcif2client1_rd_rsp_valid
  ,mcif2client1_rd_rsp_ready
  ,mcif2client1_rd_rsp_pd
  ,client12mcif_lat_fifo_depth
  ,client22mcif_rd_cdt_lat_fifo_pop
  ,client22mcif_rd_req_valid
  ,client22mcif_rd_req_pd
  ,client22mcif_rd_req_ready
  ,client22mcif_rd_axid
  ,mcif2client2_rd_rsp_valid
  ,mcif2client2_rd_rsp_ready
  ,mcif2client2_rd_rsp_pd
  ,client22mcif_lat_fifo_depth
  ,client32mcif_rd_cdt_lat_fifo_pop
  ,client32mcif_rd_req_valid
  ,client32mcif_rd_req_pd
  ,client32mcif_rd_req_ready
  ,client32mcif_rd_axid
  ,mcif2client3_rd_rsp_valid
  ,mcif2client3_rd_rsp_ready
  ,mcif2client3_rd_rsp_pd
  ,client32mcif_lat_fifo_depth
  ,client42mcif_rd_cdt_lat_fifo_pop
  ,client42mcif_rd_req_valid
  ,client42mcif_rd_req_pd
  ,client42mcif_rd_req_ready
  ,client42mcif_rd_axid
  ,mcif2client4_rd_rsp_valid
  ,mcif2client4_rd_rsp_ready
  ,mcif2client4_rd_rsp_pd
  ,client42mcif_lat_fifo_depth
  ,client52mcif_rd_cdt_lat_fifo_pop
  ,client52mcif_rd_req_valid
  ,client52mcif_rd_req_pd
  ,client52mcif_rd_req_ready
  ,client52mcif_rd_axid
  ,mcif2client5_rd_rsp_valid
  ,mcif2client5_rd_rsp_ready
  ,mcif2client5_rd_rsp_pd
  ,client52mcif_lat_fifo_depth
  ,client62mcif_rd_cdt_lat_fifo_pop
  ,client62mcif_rd_req_valid
  ,client62mcif_rd_req_pd
  ,client62mcif_rd_req_ready
  ,client62mcif_rd_axid
  ,mcif2client6_rd_rsp_valid
  ,mcif2client6_rd_rsp_ready
  ,mcif2client6_rd_rsp_pd
  ,client62mcif_lat_fifo_depth
  ,client72mcif_rd_cdt_lat_fifo_pop//zyx add
  ,client72mcif_rd_req_valid
  ,client72mcif_rd_req_pd
  ,client72mcif_rd_req_ready
  ,client72mcif_rd_axid
  ,mcif2client7_rd_rsp_valid
  ,mcif2client7_rd_rsp_ready
  ,mcif2client7_rd_rsp_pd
  ,client72mcif_lat_fifo_depth
  ,client02mcif_wr_req_pd
  ,client02mcif_wr_req_valid
  ,client02mcif_wr_req_ready
  ,client02mcif_wr_axid
  ,mcif2client0_wr_rsp_complete
  ,client12mcif_wr_req_pd
  ,client12mcif_wr_req_valid
  ,client12mcif_wr_req_ready
  ,client12mcif_wr_axid
  ,mcif2client1_wr_rsp_complete
  ,client22mcif_wr_req_pd
  ,client22mcif_wr_req_valid
  ,client22mcif_wr_req_ready
  ,client22mcif_wr_axid
  ,mcif2client2_wr_rsp_complete
  ,client32mcif_wr_req_pd//zyx add
  ,client32mcif_wr_req_valid
  ,client32mcif_wr_req_ready
  ,client32mcif_wr_axid
  ,mcif2client3_wr_rsp_complete

//| eperl: generated_end (DO NOT EDIT ABOVE)
  ,csb2mcif_req_pd //|< i
  ,csb2mcif_req_pvld //|< i
  ,csb2mcif_req_prdy //|> o
  ,noc2mcif_axi_b_bid //|< i
  ,noc2mcif_axi_b_bvalid //|< i
  ,noc2mcif_axi_r_rdata //|< i
  ,noc2mcif_axi_r_rid //|< i
  ,noc2mcif_axi_r_rlast //|< i
  ,noc2mcif_axi_r_rvalid //|< i
  ,mcif2noc_axi_ar_arready //|< i
  ,mcif2noc_axi_aw_awready //|< i
  ,mcif2noc_axi_w_wready //|< i
  ,mcif2csb_resp_pd //|> o
  ,mcif2csb_resp_valid //|> o
  ,mcif2noc_axi_ar_araddr //|> o
  ,mcif2noc_axi_ar_arid //|> o
  ,mcif2noc_axi_ar_arlen //|> o
  ,mcif2noc_axi_ar_arvalid //|> o
  ,mcif2noc_axi_aw_awaddr //|> o
  ,mcif2noc_axi_aw_awid //|> o
  ,mcif2noc_axi_aw_awlen //|> o
  ,mcif2noc_axi_aw_awvalid //|> o
  ,mcif2noc_axi_w_wdata //|> o
  ,mcif2noc_axi_w_wlast //|> o
  ,mcif2noc_axi_w_wstrb //|> o
  ,mcif2noc_axi_w_wvalid //|> o
  ,noc2mcif_axi_b_bready //|> o
  ,noc2mcif_axi_r_rready //|> o
);

input client02mcif_rd_cdt_lat_fifo_pop;
input [3:0] client02mcif_rd_axid;
input client02mcif_rd_req_valid;
input [32 +14:0] client02mcif_rd_req_pd;
output client02mcif_rd_req_ready;
output mcif2client0_rd_rsp_valid;
input mcif2client0_rd_rsp_ready;
output [64 +1 -1:0] mcif2client0_rd_rsp_pd;
input [7:0] client02mcif_lat_fifo_depth;

input client12mcif_rd_cdt_lat_fifo_pop;
input [3:0] client12mcif_rd_axid;
input client12mcif_rd_req_valid;
input [32 +14:0] client12mcif_rd_req_pd;
output client12mcif_rd_req_ready;
output mcif2client1_rd_rsp_valid;
input mcif2client1_rd_rsp_ready;
output [64 +1 -1:0] mcif2client1_rd_rsp_pd;
input [7:0] client12mcif_lat_fifo_depth;

input client22mcif_rd_cdt_lat_fifo_pop;
input [3:0] client22mcif_rd_axid;
input client22mcif_rd_req_valid;
input [32 +14:0] client22mcif_rd_req_pd;
output client22mcif_rd_req_ready;
output mcif2client2_rd_rsp_valid;
input mcif2client2_rd_rsp_ready;
output [64 +1 -1:0] mcif2client2_rd_rsp_pd;
input [7:0] client22mcif_lat_fifo_depth;

input client32mcif_rd_cdt_lat_fifo_pop;
input [3:0] client32mcif_rd_axid;
input client32mcif_rd_req_valid;
input [32 +14:0] client32mcif_rd_req_pd;
output client32mcif_rd_req_ready;
output mcif2client3_rd_rsp_valid;
input mcif2client3_rd_rsp_ready;
output [64 +1 -1:0] mcif2client3_rd_rsp_pd;
input [7:0] client32mcif_lat_fifo_depth;

input client42mcif_rd_cdt_lat_fifo_pop;
input [3:0] client42mcif_rd_axid;
input client42mcif_rd_req_valid;
input [32 +14:0] client42mcif_rd_req_pd;
output client42mcif_rd_req_ready;
output mcif2client4_rd_rsp_valid;
input mcif2client4_rd_rsp_ready;
output [64 +1 -1:0] mcif2client4_rd_rsp_pd;
input [7:0] client42mcif_lat_fifo_depth;

input client52mcif_rd_cdt_lat_fifo_pop;
input [3:0] client52mcif_rd_axid;
input client52mcif_rd_req_valid;
input [32 +14:0] client52mcif_rd_req_pd;
output client52mcif_rd_req_ready;
output mcif2client5_rd_rsp_valid;
input mcif2client5_rd_rsp_ready;
output [64 +1 -1:0] mcif2client5_rd_rsp_pd;
input [7:0] client52mcif_lat_fifo_depth;

input client62mcif_rd_cdt_lat_fifo_pop;
input [3:0] client62mcif_rd_axid;
input client62mcif_rd_req_valid;
input [32 +14:0] client62mcif_rd_req_pd;
output client62mcif_rd_req_ready;
output mcif2client6_rd_rsp_valid;
input mcif2client6_rd_rsp_ready;
output [64 +1 -1:0] mcif2client6_rd_rsp_pd;
input [7:0] client62mcif_lat_fifo_depth;

//zyx add
input client72mcif_rd_cdt_lat_fifo_pop;
input [3:0] client72mcif_rd_axid;
input client72mcif_rd_req_valid;
input [32 +14:0] client72mcif_rd_req_pd;
output client72mcif_rd_req_ready;
output mcif2client7_rd_rsp_valid;
input mcif2client7_rd_rsp_ready;
output [64 +1 -1:0] mcif2client7_rd_rsp_pd;
input [7:0] client72mcif_lat_fifo_depth;

input [64 +1:0] client02mcif_wr_req_pd;
input [3:0] client02mcif_wr_axid;
input client02mcif_wr_req_valid;
output client02mcif_wr_req_ready;
output mcif2client0_wr_rsp_complete;

input [64 +1:0] client12mcif_wr_req_pd;
input [3:0] client12mcif_wr_axid;
input client12mcif_wr_req_valid;
output client12mcif_wr_req_ready;
output mcif2client1_wr_rsp_complete;

input [64 +1:0] client22mcif_wr_req_pd;
input [3:0] client22mcif_wr_axid;
input client22mcif_wr_req_valid;
output client22mcif_wr_req_ready;
output mcif2client2_wr_rsp_complete;

//zyx add
input [64 +1:0] client32mcif_wr_req_pd;
input [3:0] client32mcif_wr_axid;
input client32mcif_wr_req_valid;
output client32mcif_wr_req_ready;
output mcif2client3_wr_rsp_complete;

//| eperl: generated_end (DO NOT EDIT ABOVE)
input nvdla_core_clk;
input nvdla_core_rstn;
input [31:0] pwrbus_ram_pd;
input csb2mcif_req_pvld; /* data valid */
output csb2mcif_req_prdy; /* data return handshake */
input [62:0] csb2mcif_req_pd;
output mcif2csb_resp_valid; /* data valid */
output [33:0] mcif2csb_resp_pd; /* pkt_id_width=1 pkt_widths=33,33  */
output mcif2noc_axi_ar_arvalid; /* data valid */
input mcif2noc_axi_ar_arready; /* data return handshake */
output [7:0] mcif2noc_axi_ar_arid;
output [3:0] mcif2noc_axi_ar_arlen;
output [32 -1:0] mcif2noc_axi_ar_araddr;
output mcif2noc_axi_aw_awvalid; /* data valid */
input mcif2noc_axi_aw_awready; /* data return handshake */
output [7:0] mcif2noc_axi_aw_awid;
output [3:0] mcif2noc_axi_aw_awlen;
output [32 -1:0] mcif2noc_axi_aw_awaddr;
output mcif2noc_axi_w_wvalid; /* data valid */
input mcif2noc_axi_w_wready; /* data return handshake */
output [64 -1:0] mcif2noc_axi_w_wdata;
output [64/8-1:0] mcif2noc_axi_w_wstrb;
output mcif2noc_axi_w_wlast;
input noc2mcif_axi_b_bvalid; /* data valid */
output noc2mcif_axi_b_bready; /* data return handshake */
input [7:0] noc2mcif_axi_b_bid;
input noc2mcif_axi_r_rvalid; /* data valid */
output noc2mcif_axi_r_rready; /* data return handshake */
input [7:0] noc2mcif_axi_r_rid;
input noc2mcif_axi_r_rlast;
input [64 -1:0] noc2mcif_axi_r_rdata;

wire [7:0] reg2dp_rd_weight_bdma;
wire [7:0] reg2dp_rd_weight_cdma_dat;
wire [7:0] client02mcif_rd_wt = reg2dp_rd_weight_cdma_dat;

wire [7:0] reg2dp_rd_weight_cdma_wt;
wire [7:0] client12mcif_rd_wt = reg2dp_rd_weight_cdma_wt;

wire [7:0] reg2dp_rd_weight_cdp;
wire [7:0] client22mcif_rd_wt = reg2dp_rd_weight_cdp;

wire [7:0] reg2dp_rd_weight_pdp;
wire [7:0] client32mcif_rd_wt = reg2dp_rd_weight_pdp;
wire [7:0] reg2dp_rd_weight_rbk;
wire [7:0] reg2dp_rd_weight_sdp;
wire [7:0] client42mcif_rd_wt = reg2dp_rd_weight_sdp;

wire [7:0] reg2dp_rd_weight_sdp_b;
wire [7:0] client52mcif_rd_wt = reg2dp_rd_weight_sdp_b;
wire [7:0] reg2dp_rd_weight_sdp_e;
wire [7:0] reg2dp_rd_weight_sdp_n;
wire [7:0] client62mcif_rd_wt = reg2dp_rd_weight_sdp_n;
wire [7:0] reg2dp_wr_weight_bdma;
wire [7:0] reg2dp_wr_weight_sdp;
wire [7:0] client02mcif_wr_wt = reg2dp_wr_weight_sdp;

wire [7:0] reg2dp_wr_weight_cdp;
wire [7:0] client12mcif_wr_wt = reg2dp_wr_weight_cdp;

wire [7:0] reg2dp_wr_weight_pdp;
wire [7:0] client22mcif_wr_wt = reg2dp_wr_weight_pdp;
wire [7:0] reg2dp_wr_weight_rbk;
//| eperl: generated_end (DO NOT EDIT ABOVE)
wire [7:0] reg2dp_rd_os_cnt;
wire [7:0] reg2dp_wr_os_cnt;

//zyx add
wire [7:0] reg2dp_rd_weight_zdp;
wire [7:0] client72mcif_rd_wt = reg2dp_rd_weight_zdp;
//zyx add
wire [7:0] reg2dp_wr_weight_zdp;
wire [7:0] client32mcif_wr_wt = reg2dp_wr_weight_zdp;



NV_NVDLA_MCIF_csb u_csb (
   .nvdla_core_clk (nvdla_core_clk) //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn) //|< i
  ,.csb2mcif_req_pvld (csb2mcif_req_pvld) //|< i
  ,.csb2mcif_req_prdy (csb2mcif_req_prdy) //|> o
  ,.csb2mcif_req_pd (csb2mcif_req_pd[62:0]) //|< i
  ,.mcif2csb_resp_valid (mcif2csb_resp_valid) //|> o
  ,.mcif2csb_resp_pd (mcif2csb_resp_pd[33:0]) //|> o
  ,.dp2reg_idle ({1{1'b1}}) //|< ?
  ,.reg2dp_rd_os_cnt (reg2dp_rd_os_cnt[7:0]) //|> w
  ,.reg2dp_rd_weight_bdma (reg2dp_rd_weight_bdma[7:0]) //|> w
  ,.reg2dp_rd_weight_cdma_dat (reg2dp_rd_weight_cdma_dat[7:0]) //|> w
  ,.reg2dp_rd_weight_cdma_wt (reg2dp_rd_weight_cdma_wt[7:0]) //|> w
  ,.reg2dp_rd_weight_cdp (reg2dp_rd_weight_cdp[7:0]) //|> w
  ,.reg2dp_rd_weight_pdp (reg2dp_rd_weight_pdp[7:0]) //|> w
  ,.reg2dp_rd_weight_rbk (reg2dp_rd_weight_rbk[7:0]) //|> w
  ,.reg2dp_rd_weight_rsv_0 (reg2dp_rd_weight_zdp[7:0]) //|> ? zyx use
  ,.reg2dp_rd_weight_rsv_1 () //|> ?
  ,.reg2dp_rd_weight_sdp (reg2dp_rd_weight_sdp[7:0]) //|> w
  ,.reg2dp_rd_weight_sdp_b (reg2dp_rd_weight_sdp_b[7:0]) //|> w
  ,.reg2dp_rd_weight_sdp_e (reg2dp_rd_weight_sdp_e[7:0]) //|> w
  ,.reg2dp_rd_weight_sdp_n (reg2dp_rd_weight_sdp_n[7:0]) //|> w
  ,.reg2dp_wr_os_cnt (reg2dp_wr_os_cnt[7:0]) //|> w
  ,.reg2dp_wr_weight_bdma (reg2dp_wr_weight_bdma[7:0]) //|> w
  ,.reg2dp_wr_weight_cdp (reg2dp_wr_weight_cdp[7:0]) //|> w
  ,.reg2dp_wr_weight_pdp (reg2dp_wr_weight_pdp[7:0]) //|> w
  ,.reg2dp_wr_weight_rbk (reg2dp_wr_weight_rbk[7:0]) //|> w
  ,.reg2dp_wr_weight_rsv_0 (reg2dp_wr_weight_zdp[7:0]) //|> ? zyx use
  ,.reg2dp_wr_weight_rsv_1 () //|> ?
  ,.reg2dp_wr_weight_rsv_2 () //|> ?
  ,.reg2dp_wr_weight_sdp (reg2dp_wr_weight_sdp[7:0]) //|> w
  );
NV_NVDLA_NOCIF_DRAM_read u_read (
   .reg2dp_rd_os_cnt (reg2dp_rd_os_cnt[7:0]) //|< w
  ,.nvdla_core_clk (nvdla_core_clk) //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn) //|< i
  ,.pwrbus_ram_pd (pwrbus_ram_pd)

,.client02mcif_rd_cdt_lat_fifo_pop(client02mcif_rd_cdt_lat_fifo_pop)
,.client02mcif_rd_req_valid (client02mcif_rd_req_valid)
,.client02mcif_rd_req_ready (client02mcif_rd_req_ready)
,.client02mcif_rd_req_pd (client02mcif_rd_req_pd)
,.mcif2client0_rd_rsp_valid (mcif2client0_rd_rsp_valid)
,.mcif2client0_rd_rsp_ready (mcif2client0_rd_rsp_ready)
,.mcif2client0_rd_rsp_pd (mcif2client0_rd_rsp_pd)
,.client02mcif_rd_wt (client02mcif_rd_wt)
,.client02mcif_rd_axid (client02mcif_rd_axid)
,.client02mcif_lat_fifo_depth (client02mcif_lat_fifo_depth)
,.client12mcif_rd_cdt_lat_fifo_pop(client12mcif_rd_cdt_lat_fifo_pop)
,.client12mcif_rd_req_valid (client12mcif_rd_req_valid)
,.client12mcif_rd_req_ready (client12mcif_rd_req_ready)
,.client12mcif_rd_req_pd (client12mcif_rd_req_pd)
,.mcif2client1_rd_rsp_valid (mcif2client1_rd_rsp_valid)
,.mcif2client1_rd_rsp_ready (mcif2client1_rd_rsp_ready)
,.mcif2client1_rd_rsp_pd (mcif2client1_rd_rsp_pd)
,.client12mcif_rd_wt (client12mcif_rd_wt)
,.client12mcif_rd_axid (client12mcif_rd_axid)
,.client12mcif_lat_fifo_depth (client12mcif_lat_fifo_depth)
,.client22mcif_rd_cdt_lat_fifo_pop(client22mcif_rd_cdt_lat_fifo_pop)
,.client22mcif_rd_req_valid (client22mcif_rd_req_valid)
,.client22mcif_rd_req_ready (client22mcif_rd_req_ready)
,.client22mcif_rd_req_pd (client22mcif_rd_req_pd)
,.mcif2client2_rd_rsp_valid (mcif2client2_rd_rsp_valid)
,.mcif2client2_rd_rsp_ready (mcif2client2_rd_rsp_ready)
,.mcif2client2_rd_rsp_pd (mcif2client2_rd_rsp_pd)
,.client22mcif_rd_wt (client22mcif_rd_wt)
,.client22mcif_rd_axid (client22mcif_rd_axid)
,.client22mcif_lat_fifo_depth (client22mcif_lat_fifo_depth)
,.client32mcif_rd_cdt_lat_fifo_pop(client32mcif_rd_cdt_lat_fifo_pop)
,.client32mcif_rd_req_valid (client32mcif_rd_req_valid)
,.client32mcif_rd_req_ready (client32mcif_rd_req_ready)
,.client32mcif_rd_req_pd (client32mcif_rd_req_pd)
,.mcif2client3_rd_rsp_valid (mcif2client3_rd_rsp_valid)
,.mcif2client3_rd_rsp_ready (mcif2client3_rd_rsp_ready)
,.mcif2client3_rd_rsp_pd (mcif2client3_rd_rsp_pd)
,.client32mcif_rd_wt (client32mcif_rd_wt)
,.client32mcif_rd_axid (client32mcif_rd_axid)
,.client32mcif_lat_fifo_depth (client32mcif_lat_fifo_depth)
,.client42mcif_rd_cdt_lat_fifo_pop(client42mcif_rd_cdt_lat_fifo_pop)
,.client42mcif_rd_req_valid (client42mcif_rd_req_valid)
,.client42mcif_rd_req_ready (client42mcif_rd_req_ready)
,.client42mcif_rd_req_pd (client42mcif_rd_req_pd)
,.mcif2client4_rd_rsp_valid (mcif2client4_rd_rsp_valid)
,.mcif2client4_rd_rsp_ready (mcif2client4_rd_rsp_ready)
,.mcif2client4_rd_rsp_pd (mcif2client4_rd_rsp_pd)
,.client42mcif_rd_wt (client42mcif_rd_wt)
,.client42mcif_rd_axid (client42mcif_rd_axid)
,.client42mcif_lat_fifo_depth (client42mcif_lat_fifo_depth)
,.client52mcif_rd_cdt_lat_fifo_pop(client52mcif_rd_cdt_lat_fifo_pop)
,.client52mcif_rd_req_valid (client52mcif_rd_req_valid)
,.client52mcif_rd_req_ready (client52mcif_rd_req_ready)
,.client52mcif_rd_req_pd (client52mcif_rd_req_pd)
,.mcif2client5_rd_rsp_valid (mcif2client5_rd_rsp_valid)
,.mcif2client5_rd_rsp_ready (mcif2client5_rd_rsp_ready)
,.mcif2client5_rd_rsp_pd (mcif2client5_rd_rsp_pd)
,.client52mcif_rd_wt (client52mcif_rd_wt)
,.client52mcif_rd_axid (client52mcif_rd_axid)
,.client52mcif_lat_fifo_depth (client52mcif_lat_fifo_depth)
,.client62mcif_rd_cdt_lat_fifo_pop(client62mcif_rd_cdt_lat_fifo_pop)
,.client62mcif_rd_req_valid (client62mcif_rd_req_valid)
,.client62mcif_rd_req_ready (client62mcif_rd_req_ready)
,.client62mcif_rd_req_pd (client62mcif_rd_req_pd)
,.mcif2client6_rd_rsp_valid (mcif2client6_rd_rsp_valid)
,.mcif2client6_rd_rsp_ready (mcif2client6_rd_rsp_ready)
,.mcif2client6_rd_rsp_pd (mcif2client6_rd_rsp_pd)
,.client62mcif_rd_wt (client62mcif_rd_wt)
,.client62mcif_rd_axid (client62mcif_rd_axid)
,.client62mcif_lat_fifo_depth (client62mcif_lat_fifo_depth)
,.client72mcif_rd_cdt_lat_fifo_pop(client72mcif_rd_cdt_lat_fifo_pop)//zyx add
,.client72mcif_rd_req_valid (client72mcif_rd_req_valid)
,.client72mcif_rd_req_ready (client72mcif_rd_req_ready)
,.client72mcif_rd_req_pd (client72mcif_rd_req_pd)
,.mcif2client7_rd_rsp_valid (mcif2client7_rd_rsp_valid)
,.mcif2client7_rd_rsp_ready (mcif2client7_rd_rsp_ready)
,.mcif2client7_rd_rsp_pd (mcif2client7_rd_rsp_pd)
,.client72mcif_rd_wt (client72mcif_rd_wt)
,.client72mcif_rd_axid (client72mcif_rd_axid)
,.client72mcif_lat_fifo_depth (client72mcif_lat_fifo_depth)

//| eperl: generated_end (DO NOT EDIT ABOVE)
  ,.mcif2noc_axi_ar_arvalid (mcif2noc_axi_ar_arvalid) //|> o
  ,.mcif2noc_axi_ar_arready (mcif2noc_axi_ar_arready) //|< i
  ,.mcif2noc_axi_ar_arid (mcif2noc_axi_ar_arid) //|> o
  ,.mcif2noc_axi_ar_arlen (mcif2noc_axi_ar_arlen) //|> o
  ,.mcif2noc_axi_ar_araddr (mcif2noc_axi_ar_araddr) //|> o
  ,.noc2mcif_axi_r_rvalid (noc2mcif_axi_r_rvalid) //|< i
  ,.noc2mcif_axi_r_rready (noc2mcif_axi_r_rready) //|> o
  ,.noc2mcif_axi_r_rid (noc2mcif_axi_r_rid) //|< i
  ,.noc2mcif_axi_r_rlast (noc2mcif_axi_r_rlast) //|< i
  ,.noc2mcif_axi_r_rdata (noc2mcif_axi_r_rdata) //|< i
);
NV_NVDLA_NOCIF_DRAM_write u_write (
  .nvdla_core_clk (nvdla_core_clk) //|< i
  ,.nvdla_core_rstn (nvdla_core_rstn) //|< i
  ,.pwrbus_ram_pd (pwrbus_ram_pd)
  ,.reg2dp_wr_os_cnt (reg2dp_wr_os_cnt)

,.client02mcif_wr_req_valid(client02mcif_wr_req_valid)
,.client02mcif_wr_req_ready(client02mcif_wr_req_ready)
,.client02mcif_wr_req_pd(client02mcif_wr_req_pd)
,.client02mcif_wr_wt(client02mcif_wr_wt)
,.client02mcif_wr_axid(client02mcif_wr_axid)
,.mcif2client0_wr_rsp_complete(mcif2client0_wr_rsp_complete)
,.client12mcif_wr_req_valid(client12mcif_wr_req_valid)
,.client12mcif_wr_req_ready(client12mcif_wr_req_ready)
,.client12mcif_wr_req_pd(client12mcif_wr_req_pd)
,.client12mcif_wr_wt(client12mcif_wr_wt)
,.client12mcif_wr_axid(client12mcif_wr_axid)
,.mcif2client1_wr_rsp_complete(mcif2client1_wr_rsp_complete)
,.client22mcif_wr_req_valid(client22mcif_wr_req_valid)
,.client22mcif_wr_req_ready(client22mcif_wr_req_ready)
,.client22mcif_wr_req_pd(client22mcif_wr_req_pd)
,.client22mcif_wr_wt(client22mcif_wr_wt)
,.client22mcif_wr_axid(client22mcif_wr_axid)
,.mcif2client2_wr_rsp_complete(mcif2client2_wr_rsp_complete)
,.client32mcif_wr_req_valid(client32mcif_wr_req_valid)//zyx add
,.client32mcif_wr_req_ready(client32mcif_wr_req_ready)
,.client32mcif_wr_req_pd(client32mcif_wr_req_pd)
,.client32mcif_wr_wt(client32mcif_wr_wt)
,.client32mcif_wr_axid(client32mcif_wr_axid)
,.mcif2client3_wr_rsp_complete(mcif2client3_wr_rsp_complete)

//| eperl: generated_end (DO NOT EDIT ABOVE)
  ,.mcif2noc_axi_aw_awvalid (mcif2noc_axi_aw_awvalid) //|> o
  ,.mcif2noc_axi_aw_awready (mcif2noc_axi_aw_awready) //|< i
  ,.mcif2noc_axi_aw_awid (mcif2noc_axi_aw_awid) //|> o
  ,.mcif2noc_axi_aw_awlen (mcif2noc_axi_aw_awlen) //|> o
  ,.mcif2noc_axi_aw_awaddr (mcif2noc_axi_aw_awaddr) //|> o
  ,.mcif2noc_axi_w_wvalid (mcif2noc_axi_w_wvalid) //|> o
  ,.mcif2noc_axi_w_wready (mcif2noc_axi_w_wready) //|< i
  ,.mcif2noc_axi_w_wdata (mcif2noc_axi_w_wdata) //|> o
  ,.mcif2noc_axi_w_wstrb (mcif2noc_axi_w_wstrb) //|> o
  ,.mcif2noc_axi_w_wlast (mcif2noc_axi_w_wlast) //|> o
  ,.noc2mcif_axi_b_bvalid (noc2mcif_axi_b_bvalid) //|< i
  ,.noc2mcif_axi_b_bready (noc2mcif_axi_b_bready) //|> o
  ,.noc2mcif_axi_b_bid (noc2mcif_axi_b_bid) //|< i
);
endmodule
