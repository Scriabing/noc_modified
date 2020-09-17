`timescale 1ns / 1ps

`define DATABUS2MEM_WIDTH `AXI_DATA_WIDTH
//`define AXI_DATA_WIDTH 64	
`define AXI_MAX_BURST_LEN 256
`define log2AXI_MAX_BURST_LEN 3
`define MEM_WIDTH 32
`define AXI_ADDR_WIDTH 32
`define MEM_SIZE (1<<30)
`define _SIMULATE_X_VH_
`define NV_HWACC_NVDLA_tick_defines_vh



`define x_or_0 1'b0
`define x_or_1 1'b1


`define tick_x_or_0 1'b0
`define tick_x_or_1 1'b1



module testbench;

parameter integer C_M_AXI_ID_WIDTH	= 8;

bit clk;//都可以用logic去自动推断
logic rst_n;

//////////////////////////////////////////////////
logic client02mcif_rd_cdt_lat_fifo_pop;
logic client02mcif_rd_req_valid;
logic [47 -1:0] client02mcif_rd_req_pd;
logic client02mcif_rd_req_ready;
logic mcif2client0_rd_rsp_valid;
logic mcif2client0_rd_rsp_ready;
logic [65 -1:0] mcif2client0_rd_rsp_pd;
logic [7:0] client02mcif_lat_fifo_depth;
logic [3:0] client02mcif_rd_axid;


logic client12mcif_rd_cdt_lat_fifo_pop;
logic client12mcif_rd_req_valid;
logic [47 -1:0] client12mcif_rd_req_pd;
logic client12mcif_rd_req_ready;
logic mcif2client1_rd_rsp_valid;
logic mcif2client1_rd_rsp_ready;
logic [65 -1:0] mcif2client1_rd_rsp_pd;
logic [7:0] client12mcif_lat_fifo_depth;
logic [3:0] client12mcif_rd_axid;

logic client22mcif_rd_cdt_lat_fifo_pop;
logic client22mcif_rd_req_valid;
logic [47 -1:0] client22mcif_rd_req_pd;
logic client22mcif_rd_req_ready;
logic mcif2client2_rd_rsp_valid;
logic mcif2client2_rd_rsp_ready;
logic [65 -1:0] mcif2client2_rd_rsp_pd;
logic [7:0] client22mcif_lat_fifo_depth;
logic [3:0] client22mcif_rd_axid;

logic client32mcif_rd_cdt_lat_fifo_pop;
logic client32mcif_rd_req_valid;
logic [47 -1:0] client32mcif_rd_req_pd;
logic client32mcif_rd_req_ready;
logic mcif2client3_rd_rsp_valid;
logic mcif2client3_rd_rsp_ready;
logic [65 -1:0] mcif2client3_rd_rsp_pd;
logic [7:0] client32mcif_lat_fifo_depth;
logic [3:0] client32mcif_rd_axid;

logic client42mcif_rd_cdt_lat_fifo_pop;
logic client42mcif_rd_req_valid;
logic [47 -1:0] client42mcif_rd_req_pd;
logic client42mcif_rd_req_ready;
logic mcif2client4_rd_rsp_valid;
logic mcif2client4_rd_rsp_ready;
logic [65 -1:0] mcif2client4_rd_rsp_pd;
logic [7:0] client42mcif_lat_fifo_depth;
logic [3:0] client42mcif_rd_axid;

logic client52mcif_rd_cdt_lat_fifo_pop;
logic client52mcif_rd_req_valid;
logic [47 -1:0] client52mcif_rd_req_pd;
logic client52mcif_rd_req_ready;
logic mcif2client5_rd_rsp_valid;
logic mcif2client5_rd_rsp_ready;
logic [65 -1:0] mcif2client5_rd_rsp_pd;
logic [7:0] client52mcif_lat_fifo_depth;
logic [3:0] client52mcif_rd_axid;

logic client62mcif_rd_cdt_lat_fifo_pop;
logic client62mcif_rd_req_valid;
logic [47 -1:0] client62mcif_rd_req_pd;
logic client62mcif_rd_req_ready;
logic mcif2client6_rd_rsp_valid;
logic mcif2client6_rd_rsp_ready;
logic [65 -1:0] mcif2client6_rd_rsp_pd;
logic [7:0] client62mcif_lat_fifo_depth;
logic [3:0] client62mcif_rd_axid;

logic client72mcif_rd_cdt_lat_fifo_pop;
logic client72mcif_rd_req_valid;
logic [47 -1:0] client72mcif_rd_req_pd;
logic client72mcif_rd_req_ready;
logic mcif2client7_rd_rsp_valid;
logic mcif2client7_rd_rsp_ready;
logic [65 -1:0] mcif2client7_rd_rsp_pd;
logic [7:0] client72mcif_lat_fifo_depth;
logic [3:0] client72mcif_rd_axid;

logic [66 -1:0] client02mcif_wr_req_pd;
logic client02mcif_wr_req_valid;
logic client02mcif_wr_req_ready;
logic mcif2client0_wr_rsp_complete;
logic [3:0] client02mcif_wr_axid;

logic [66 -1:0] client12mcif_wr_req_pd;
logic client12mcif_wr_req_valid;
logic client12mcif_wr_req_ready;
logic mcif2client1_wr_rsp_complete;
logic [3:0] client12mcif_wr_axid;

logic [66 -1:0] client22mcif_wr_req_pd;
logic client22mcif_wr_req_valid;
logic client22mcif_wr_req_ready;
logic mcif2client2_wr_rsp_complete;
logic [3:0] client22mcif_wr_axid;

logic [66 -1:0] client32mcif_wr_req_pd;
logic client32mcif_wr_req_valid;
logic client32mcif_wr_req_ready;
logic mcif2client3_wr_rsp_complete;
logic [3:0] client32mcif_wr_axid;
//////////////////////////////////////////////////
logic csb2mcif_req_pvld; /* data valid */
logic csb2mcif_req_prdy; /* data return handshake */
logic [62:0] csb2mcif_req_pd;
logic mcif2csb_resp_valid; /* data valid ,这里读不用看rdy*/
logic [33:0] mcif2csb_resp_pd; 

//////////////////////////////////////////////////
wire [C_M_AXI_ID_WIDTH-1 : 0] M_AXI_AWID;
wire [32-1 : 0] M_AXI_AWADDR;
wire [`log2AXI_MAX_BURST_LEN : 0] M_AXI_AWLEN;
wire [2 : 0] M_AXI_AWSIZE;
wire [1 : 0] M_AXI_AWBURST;
wire  M_AXI_AWLOCK;
wire [3 : 0] M_AXI_AWCACHE;
wire [2 : 0] M_AXI_AWPROT;
wire [3 : 0] M_AXI_AWQOS;
wire M_AXI_AWVALID;
wire  M_AXI_AWREADY;
wire [`AXI_DATA_WIDTH-1 : 0] M_AXI_WDATA;
wire [`AXI_DATA_WIDTH/8-1 : 0] M_AXI_WSTRB;
wire  M_AXI_WLAST;
wire  M_AXI_WVALID;
wire  M_AXI_WREADY;
wire [C_M_AXI_ID_WIDTH-1 : 0] M_AXI_BID;
wire [1 : 0] M_AXI_BRESP;
wire  M_AXI_BVALID;
wire  M_AXI_BREADY;
wire [C_M_AXI_ID_WIDTH-1 : 0] M_AXI_ARID;
wire [32-1 : 0] M_AXI_ARADDR;
wire [`log2AXI_MAX_BURST_LEN : 0] M_AXI_ARLEN;
wire [2 : 0] M_AXI_ARSIZE;
wire [1 : 0] M_AXI_ARBURST;
wire  M_AXI_ARLOCK;
wire [3 : 0] M_AXI_ARCACHE;
wire [2 : 0] M_AXI_ARPROT;
wire [3 : 0] M_AXI_ARQOS;
wire  M_AXI_ARVALID;
wire  M_AXI_ARREADY;
wire [C_M_AXI_ID_WIDTH-1 : 0] M_AXI_RID;
wire [`AXI_DATA_WIDTH-1 : 0] M_AXI_RDATA;
wire [1 : 0] M_AXI_RRESP;
wire  M_AXI_RLAST;
wire  M_AXI_RVALID;
wire  M_AXI_RREADY;
//////////////////////////////////////////////////
`include "nocif_tasks.vh"

always #5 clk=~clk;//周期是10ns

//automatic保证该变量作用范围和生命周期的拓宽
initial
begin
	//初始化要写的软件数组
	automatic bit [`AXI_DATA_WIDTH-1:0]data_wr0[]={0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15};//静态数组
	automatic bit [`AXI_DATA_WIDTH-1:0]data_wr1[]={16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31};
	automatic bit [`AXI_DATA_WIDTH-1:0]data_wr2[]={32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47};
	automatic bit [`AXI_DATA_WIDTH-1:0]data_rd0[]=new[16];//动态数组,后续可以随时修改数组大小
	automatic bit [`AXI_DATA_WIDTH-1:0]data_rd1[]=new[16];
	automatic bit [`AXI_DATA_WIDTH-1:0]data_rd2[]=new[16];
	automatic bit [`AXI_DATA_WIDTH-1:0]data_rd3[]=new[16];
	automatic bit [`AXI_DATA_WIDTH-1:0]data_rd4[]=new[16];
	automatic bit [`AXI_DATA_WIDTH-1:0]data_rd5[]=new[16];
	automatic bit [`AXI_DATA_WIDTH-1:0]data_rd6[]=new[16];
	automatic bit [`AXI_DATA_WIDTH-1:0]data_rd7[]=new[16];

	//automatic bit[22-1:0] addr ={};//根据实际地址写
	automatic bit[32-1:0] data_mcif_in = 32'h1;//给某地址写的数据
	automatic bit[32-1:0] data_mcif_out;

    client02mcif_rd_cdt_lat_fifo_pop=1'b0;
	client02mcif_lat_fifo_depth=8'd0;
	client12mcif_rd_cdt_lat_fifo_pop=1'b0;
	client12mcif_lat_fifo_depth=8'd0;
	client22mcif_rd_cdt_lat_fifo_pop=1'b0;
	client22mcif_lat_fifo_depth=8'd0;
	client32mcif_rd_cdt_lat_fifo_pop=1'b0;
	client32mcif_lat_fifo_depth=8'd0;
	client42mcif_rd_cdt_lat_fifo_pop=1'b0;
	client42mcif_lat_fifo_depth=8'd0;
	client52mcif_rd_cdt_lat_fifo_pop=1'b0;
	client52mcif_lat_fifo_depth=8'd0;
	client62mcif_rd_cdt_lat_fifo_pop=1'b0;
	client62mcif_lat_fifo_depth=8'd0;
	client72mcif_rd_cdt_lat_fifo_pop=1'b0;
	client72mcif_lat_fifo_depth=8'd0;

	//可以让后续skid buffer的rdy都初始化
	csb2mcif_req_pvld  = 1'b0;
	client02mcif_rd_req_valid = 1'b0;
	client12mcif_rd_req_valid = 1'b0;
	client22mcif_rd_req_valid = 1'b0;
	client32mcif_rd_req_valid = 1'b0;
	client42mcif_rd_req_valid = 1'b0;
	client52mcif_rd_req_valid = 1'b0;
	client62mcif_rd_req_valid = 1'b0;
	client72mcif_rd_req_valid = 1'b0;
	mcif2client0_rd_rsp_ready =1'b1;
	mcif2client1_rd_rsp_ready =1'b1;
	mcif2client2_rd_rsp_ready =1'b1;
	mcif2client3_rd_rsp_ready =1'b1;
	mcif2client4_rd_rsp_ready =1'b1;
	mcif2client5_rd_rsp_ready =1'b1;
	mcif2client6_rd_rsp_ready =1'b1;
	mcif2client7_rd_rsp_ready =1'b1;
	client02mcif_wr_req_valid = 1'b0;
	client12mcif_wr_req_valid = 1'b0;
	client22mcif_wr_req_valid = 1'b0;
	client32mcif_wr_req_valid = 1'b0;

    clk=1;
	rst_n=1;//第一拍
	#20 rst_n=0;//第3拍
	#20 rst_n=1;//第5拍
	repeat(10) @(posedge clk);//空转10拍，140ns

	//configure test 初始化就可用,暂时不用配置,主要用作软件关闭通道 的
    //63 bit csb2mcif_req_pd={2'b00/*level_NC,useless*/ , 4'b0000/*wrbe_NC useless*/ , 1'b0/*srcpriv_NC iseless */,1'bx/*nonposted for write*/ , 1'bx/*write or read*/ , 32'bx/*wdata*/,22'bx/*addr*/}
    //34 bit mcif2csb_resp_pd={1‘b0/*rd_error useless*/,32'bx/*rdata*/}
    //1.测试端口本身的读写正确性（可以通过内部信号线的功能仿真来看是否写成功 or 下面读回来看看写没写对）;2.结合下面观察设置是否起了作用,推测内部配置的基本思路;
    //addr 		 	name											description
    //b'000 		rd_weight_0_0_out            					{rd_weight_cdp(读2), rd_weight_pdp(读3), rd_weight_sdp(读4), rd_weight_bdma(空)};直接决定了读写端口的rd_wt or wr_wt信号 ,初始化得到都是1;只要wt不为0,该位置对应的口就会参与arb
    //b'001			rd_weight_1_0_out 								{rd_weight_cdma_dat(读0), rd_weight_sdp_e(空), rd_weight_sdp_n(读6),rd_weight_sdp_b(读5)}
    //b'010 		rd_weight_2_0_out  								{rd_weight_rsv_0(空), rd_weight_rsv_1(空), rd_weight_rbk(空), rd_weight_cdma_wt(读1)};
    //b'011 		wr_weight_0_0_out  								{wr_weight_cdp(写1), wr_weight_pdp(写2), wr_weight_sdp(写0), wr_weight_bdma(空)};
    //b'100 		wr_weight_1_0_out  								{wr_weight_rsv_0(空), wr_weight_rsv_1(空), wr_weight_rsv_2(空), wr_weight_rbk(空)};
    //b'101 		outstanding_cnt_0_out 							rd_os_cnt\wr,给到读写通道,初始化位b'11111111
    //b'110			status_0_out                                    (useless , constant value)
    // mcif_conf_rd(addr, data_mcif_out ,0/*nonposted*/);
    // $display("initialize %d value  = %d,addr,data_mcif_out");
    // mcif_conf_wr(addr, data_mcif_in, 0/*nonposted*/);//nonposted 弃用所以用0
    // mcif_conf_rd(addr, data_mcif_out ,0/*nonposted*/);
    // $display("custom %d value  = %d,addr,data_mcif_out");
    // $display("///////////////////////////////////////////////////");
	//configure test over//
	




	/////////////////////////////
	//1.测试读写正确性和包内的nonposted位正确性
	//////////////////////////////
	//140ns
   //开始于第15拍,每个CH？_wr都会等到该通道的complete才,会结束该task；
   //单次burst
    fork
		CH3_wr(16-1,0,0,data_wr0);//检查单命令通道下的axi的写传输效率
	join

 	fork
		CH0_wr(16-1,0,0,data_wr0);//每个通道依次写16个数,length设为15,本次命令包全都是post（b通道没有写完成）
		CH1_wr(16-1,32*100,1,data_wr1);
		CH2_wr(16-1,32*50,2,data_wr2);
		CH3_wr(16-1,0,0,data_wr0);
	
	join

	fork
		CH0_wr(16-1,32'h10000+0,0,data_wr0);
		CH1_wr(16-1,32'h10000+32*100,1,data_wr1);
		CH2_wr(16-1,32'h10000+32*200,2,data_wr2);
		CH3_wr(16-1,0,0,data_wr0);
	join

	fork
		CH0_wr(16-1,32'h20000+0,0,data_wr0);
		CH1_wr(16-1,32'h20000+32*100,1,data_wr1);
		CH2_wr(16-1,32'h20000+32*200,2,data_wr2);
		CH3_wr(16-1,0,0,data_wr0);
		
	join

	



	$display("////////////////////////////////////////////////");
	fork
		CH7_rd(16-1,0,data_rd7);//检查单命令下的axi读传输效率
	join

	fork
		CH0_rd(16-1,0,data_rd0);//
		CH1_rd(16-1,32*100,data_rd1);//addr not very high
		CH2_rd(16-1,32*50,data_rd2);
		CH3_rd(16-1,0,data_rd3);
		CH4_rd(16-1,32*100,data_rd4);
		CH5_rd(16-1,32*50,data_rd5);
		CH6_rd(16-1,32*100,data_rd6);
		CH7_rd(16-1,0,data_rd7);
	join

	for(int i=0;i<16;i++)
	begin
		$display("data_rd0[%0d]=%0d",i,data_rd0[i]);//顺序打印,这里波形里也能看出来
	end
	$display("");
	for(int i=0;i<16;i++)
	begin
		$display("data_rd1[%0d]=%0d",i,data_rd1[i]);
	end
	$display("");
	for(int i=0;i<16;i++)
	begin
		$display("data_rd2[%0d]=%0d",i,data_rd2[i]);
	end
	$display("");
	for(int i=0;i<16;i++)
	begin
		$display("data_rd3[%0d]=%0d",i,data_rd3[i]);
	end
	$display("");
	for(int i=0;i<16;i++)
	begin
		$display("data_rd4[%0d]=%0d",i,data_rd3[i]);
	end
	$display("");
	for(int i=0;i<16;i++)
	begin
		$display("data_rd5[%0d]=%0d",i,data_rd3[i]);
	end
	$display("");
	for(int i=0;i<16;i++)
	begin
		$display("data_rd6[%0d]=%0d",i,data_rd3[i]);
	end


	$display("////////////////////////////////////////////////");
	//读剩余的地址数据
	fork
		CH0_rd(16-1,32'h20000+0,data_rd0);
		CH1_rd(16-1,32'h20000+32*100,data_rd1);
		CH2_rd(16-1,32'h20000+32*100,data_rd2);
		
	join

	for(int i=0;i<16;i++)
	begin
		$display("data_rd0[%0d]=%0d",i,data_rd0[i]);
	end
	$display("");
	for(int i=0;i<16;i++)
	begin
		$display("data_rd1[%0d]=%0d",i,data_rd1[i]);
	end
	$display("");
	for(int i=0;i<16;i++)
	begin
		$display("data_rd2[%0d]=%0d",i,data_rd2[i]);
	end
	
	$display("////////////////////////////////////////////////");



	////////////////////////////////////////////////
	//2.基于fused的工作模式,测试arbiter,场景1 通道序号连发,这里重在看通道们的执行顺序（时序图）,重点不在看数据
	///////////////////////////////////////////////
	//为了查看下一的顺序是不是先2再1
	fork
		CH0_wr(16-1,32'h20000+0,0,data_wr0);
		CH1_wr(16-1,32'h20000+32*100,1,data_wr1);
	join
	fork
		CH1_wr(16-1,32'h20000+0,1,data_wr0);
		CH2_wr(16-1,32'h20000+32*100,2,data_wr2);
	join



	//同上,查看顺序,是不是6 、4 、5,主要看时序上谁先口
	fork
		CH0_rd(16-1,32'h20000+0,data_rd0);
		CH1_rd(16-1,32'h20000+32*100,data_rd3);
		CH5_rd(16-1,32'h20000+32*200,data_rd5);

	join
	fork
		CH6_rd(16-1,32'h20000+0,data_rd0);
		CH5_rd(16-1,32'h20000+32*100,data_rd3);
		CH4_rd(16-1,32'h20000+32*200,data_rd5);

	join
	//如果上面是6、4、5,这应该是6、0、5
	fork
		CH0_rd(16-1,32'h20000+0,data_rd0);
		CH5_rd(16-1,32'h20000+32*100,data_rd3);
		CH6_rd(16-1,32'h20000+32*200,data_rd5);

	join


	$display("////////////////////////////////////////////////");





	//测试csb的软件关通道能力,关读通道
	mcif_conf_rd(22'b0, data_mcif_out ,0/*nonposted*/);
    $display("initialize  value  = %d" , data_mcif_out);
    mcif_conf_wr(0, 0, 0/*nonposted*/);//关闭读2、3、4
    mcif_conf_rd(22'b0, data_mcif_out[0] ,0/*nonposted*/);
    $display("custom  value  = %d" , data_mcif_out[0]);
    $display("///////////////////////////////////////////////////");
    //看波形是否响应
    fork
		CH0_rd(16-1,0,data_rd0);
		CH1_rd(16-1,32*100,data_rd1);
		CH2_rd(16-1,32*200,data_rd2);
		CH3_rd(16-1,32'h10000+0,data_rd3);
		CH4_rd(16-1,32'h10000+32*100,data_rd4);
		CH5_rd(16-1,32'h10000+32*200,data_rd5);
		CH6_rd(16-1,32'h20000+0,data_rd6);
	join

	//关闭写通道
	mcif_conf_rd(22'b0, data_mcif_out ,0/*nonposted*/);
    $display("initialize value  = %d",data_mcif_out);
    mcif_conf_wr(22'b0, 0, 0/*nonposted*/);//关闭读2、3、4
    mcif_conf_rd(22'b0, data_mcif_out ,0/*nonposted*/);
    $display("custom  value  = %d",data_mcif_out);
    //看波形是否响应
    fork
		CH0_wr(16-1,0,0,data_wr0);//每个通道依次写16个数,length设为15,本次命令包全都是post（b通道没有写完成）
		CH1_wr(16-1,32*100,1,data_wr1);
		CH2_wr(16-1,32*200,2,data_wr2);
	
	join


	#1000 $finish;
end

//此initial块用来结束
initial
begin
#10000000 $finish;
end

NV_NVDLA_nocif u_mcif
(
	.nvdla_core_clk(clk),
	.nvdla_core_rstn(rst_n),

	//////////////////////////////////////////////////
	.client02mcif_rd_cdt_lat_fifo_pop(client02mcif_rd_cdt_lat_fifo_pop),
	.client02mcif_rd_req_valid(client02mcif_rd_req_valid),
	.client02mcif_rd_req_pd(client02mcif_rd_req_pd),
	.client02mcif_rd_req_ready(client02mcif_rd_req_ready),
	.client02mcif_lat_fifo_depth(client02mcif_lat_fifo_depth),
	.client02mcif_rd_axid(4'd8),

	.mcif2client0_rd_rsp_valid(mcif2client0_rd_rsp_valid),
	.mcif2client0_rd_rsp_pd(mcif2client0_rd_rsp_pd),
	.mcif2client0_rd_rsp_ready(mcif2client0_rd_rsp_ready),
	//////////////////////////////////////////////////
	.client12mcif_rd_cdt_lat_fifo_pop(client12mcif_rd_cdt_lat_fifo_pop),
	.client12mcif_rd_req_valid(client12mcif_rd_req_valid),
	.client12mcif_rd_req_pd(client12mcif_rd_req_pd),
	.client12mcif_rd_req_ready(client12mcif_rd_req_ready),
	.client12mcif_lat_fifo_depth(client12mcif_lat_fifo_depth),
	.client12mcif_rd_axid(4'd9 ),

	.mcif2client1_rd_rsp_valid(mcif2client1_rd_rsp_valid),
	.mcif2client1_rd_rsp_pd(mcif2client1_rd_rsp_pd),
	.mcif2client1_rd_rsp_ready(mcif2client1_rd_rsp_ready),
	//////////////////////////////////////////////////
	.client22mcif_rd_cdt_lat_fifo_pop(client22mcif_rd_cdt_lat_fifo_pop),
	.client22mcif_rd_req_valid(client22mcif_rd_req_valid),
	.client22mcif_rd_req_pd(client22mcif_rd_req_pd),
	.client22mcif_rd_req_ready(client22mcif_rd_req_ready),
	.client22mcif_lat_fifo_depth(client22mcif_lat_fifo_depth),
	.client22mcif_rd_axid(4'd3),

	.mcif2client2_rd_rsp_valid(mcif2client2_rd_rsp_valid),
	.mcif2client2_rd_rsp_pd(mcif2client2_rd_rsp_pd),
	.mcif2client2_rd_rsp_ready(mcif2client2_rd_rsp_ready),
	//////////////////////////////////////////////////
	.client32mcif_rd_cdt_lat_fifo_pop(client32mcif_rd_cdt_lat_fifo_pop),
	.client32mcif_rd_req_valid(client32mcif_rd_req_valid),
	.client32mcif_rd_req_pd(client32mcif_rd_req_pd),
	.client32mcif_rd_req_ready(client32mcif_rd_req_ready),
	.client32mcif_lat_fifo_depth(client32mcif_lat_fifo_depth),
	.client32mcif_rd_axid(4'd2 ),

	.mcif2client3_rd_rsp_valid(mcif2client3_rd_rsp_valid),
	.mcif2client3_rd_rsp_pd(mcif2client3_rd_rsp_pd),
	.mcif2client3_rd_rsp_ready(mcif2client3_rd_rsp_ready),
	//////////////////////////////////////////////////
	.client42mcif_rd_cdt_lat_fifo_pop(client42mcif_rd_cdt_lat_fifo_pop),
	.client42mcif_rd_req_valid(client42mcif_rd_req_valid),
	.client42mcif_rd_req_pd(client42mcif_rd_req_pd),
	.client42mcif_rd_req_ready(client42mcif_rd_req_ready),
	.client42mcif_lat_fifo_depth(client42mcif_lat_fifo_depth),
	.client42mcif_rd_axid(4'd1 ),

	.mcif2client4_rd_rsp_valid(mcif2client4_rd_rsp_valid),
	.mcif2client4_rd_rsp_pd(mcif2client4_rd_rsp_pd),
	.mcif2client4_rd_rsp_ready(mcif2client4_rd_rsp_ready),
	//////////////////////////////////////////////////
	.client52mcif_rd_cdt_lat_fifo_pop(client52mcif_rd_cdt_lat_fifo_pop),
	.client52mcif_rd_req_valid(client52mcif_rd_req_valid),
	.client52mcif_rd_req_pd(client52mcif_rd_req_pd),
	.client52mcif_rd_req_ready(client52mcif_rd_req_ready),
	.client52mcif_lat_fifo_depth(client52mcif_lat_fifo_depth),
	.client52mcif_rd_axid(4'd5),

	.mcif2client5_rd_rsp_valid(mcif2client5_rd_rsp_valid),
	.mcif2client5_rd_rsp_pd(mcif2client5_rd_rsp_pd),
	.mcif2client5_rd_rsp_ready(mcif2client5_rd_rsp_ready),
	//////////////////////////////////////////////////
	.client62mcif_rd_cdt_lat_fifo_pop(client62mcif_rd_cdt_lat_fifo_pop),
	.client62mcif_rd_req_valid(client62mcif_rd_req_valid),
	.client62mcif_rd_req_pd(client62mcif_rd_req_pd),
	.client62mcif_rd_req_ready(client62mcif_rd_req_ready),
	.client62mcif_lat_fifo_depth(client62mcif_lat_fifo_depth),
	.client62mcif_rd_axid(4'd6),

	.mcif2client6_rd_rsp_valid(mcif2client6_rd_rsp_valid),
	.mcif2client6_rd_rsp_pd(mcif2client6_rd_rsp_pd),
	.mcif2client6_rd_rsp_ready(mcif2client6_rd_rsp_ready),
	//////////////////////////////////////////////////
	.client72mcif_rd_cdt_lat_fifo_pop(client72mcif_rd_cdt_lat_fifo_pop),
	.client72mcif_rd_req_valid(client72mcif_rd_req_valid),
	.client72mcif_rd_req_pd(client72mcif_rd_req_pd),
	.client72mcif_rd_req_ready(client72mcif_rd_req_ready),
	.client72mcif_lat_fifo_depth(client72mcif_lat_fifo_depth),
	.client72mcif_rd_axid(4'd4),

	.mcif2client7_rd_rsp_valid(mcif2client7_rd_rsp_valid),
	.mcif2client7_rd_rsp_pd(mcif2client7_rd_rsp_pd),
	.mcif2client7_rd_rsp_ready(mcif2client7_rd_rsp_ready),
	//////////////////////////////////////////////////
	.client02mcif_wr_req_pd(client02mcif_wr_req_pd),
    .client02mcif_wr_req_valid(client02mcif_wr_req_valid),
    .client02mcif_wr_req_ready(client02mcif_wr_req_ready),
    .mcif2client0_wr_rsp_complete(mcif2client0_wr_rsp_complete),
    .client02mcif_wr_axid(4'd1 ),
	//////////////////////////////////////////////////
	.client12mcif_wr_req_pd(client12mcif_wr_req_pd),
    .client12mcif_wr_req_valid(client12mcif_wr_req_valid),
    .client12mcif_wr_req_ready(client12mcif_wr_req_ready),
    .mcif2client1_wr_rsp_complete(mcif2client1_wr_rsp_complete),
    .client12mcif_wr_axid(4'd2),
	//////////////////////////////////////////////////
	.client22mcif_wr_req_pd(client22mcif_wr_req_pd),
    .client22mcif_wr_req_valid(client22mcif_wr_req_valid),
    .client22mcif_wr_req_ready(client22mcif_wr_req_ready),
    .mcif2client2_wr_rsp_complete(mcif2client2_wr_rsp_complete),
    .client22mcif_wr_axid(4'd3),
	//////////////////////////////////////////////////
	.client32mcif_wr_req_pd(client32mcif_wr_req_pd),
    .client32mcif_wr_req_valid(client32mcif_wr_req_valid),
    .client32mcif_wr_req_ready(client32mcif_wr_req_ready),
    .mcif2client3_wr_rsp_complete(mcif2client3_wr_rsp_complete),
    .client32mcif_wr_axid(4'd4),
	//////////////////////////////////////////////////

 
    //configurable
	.csb2mcif_req_pd(csb2mcif_req_pd),
    .csb2mcif_req_pvld(csb2mcif_req_pvld),
    .csb2mcif_req_prdy(csb2mcif_req_prdy),
    .mcif2csb_resp_pd(mcif2csb_resp_pd),
    .mcif2csb_resp_valid(mcif2csb_resp_valid),


	//AW channel
	.mcif2noc_axi_aw_awaddr(M_AXI_AWADDR),
    .mcif2noc_axi_aw_awid(M_AXI_AWID), 
    .mcif2noc_axi_aw_awlen(M_AXI_AWLEN), 
    .mcif2noc_axi_aw_awvalid(M_AXI_AWVALID), 
    .mcif2noc_axi_aw_awready(M_AXI_AWREADY),
	
	//Wr channel
	.mcif2noc_axi_w_wdata(M_AXI_WDATA),
    .mcif2noc_axi_w_wlast(M_AXI_WLAST),
    .mcif2noc_axi_w_wstrb(M_AXI_WSTRB),//={(`AXI_DATA_WIDTH/8){1'b1}};,来自nocif内部,也可以固定大小
    .mcif2noc_axi_w_wvalid(M_AXI_WVALID),
    .mcif2noc_axi_w_wready(M_AXI_WREADY),

    //B channel
	.noc2mcif_axi_b_bready(M_AXI_BREADY),
    .noc2mcif_axi_b_bid(M_AXI_BID),
    .noc2mcif_axi_b_bvalid(M_AXI_BVALID),

	
	//AR channel
	.mcif2noc_axi_ar_arready(M_AXI_ARREADY),
    .mcif2noc_axi_ar_araddr(M_AXI_ARADDR),
    .mcif2noc_axi_ar_arid(M_AXI_ARID),
    .mcif2noc_axi_ar_arlen(M_AXI_ARLEN),
    .mcif2noc_axi_ar_arvalid(M_AXI_ARVALID),

	//Rd channel
	.noc2mcif_axi_r_rdata(M_AXI_RDATA),
    .noc2mcif_axi_r_rid(M_AXI_RID),
    .noc2mcif_axi_r_rlast(M_AXI_RLAST),
    .noc2mcif_axi_r_rvalid(M_AXI_RVALID),
    .noc2mcif_axi_r_rready(M_AXI_RREADY),
    .pwrbus_ram_pd(32'b0)
);

AXI_HP_Slave #
(
	.C_S_AXI_DATA_WIDTH(`AXI_DATA_WIDTH),
	.C_S_AXI_ADDR_WIDTH(32)
)u_AXI_HP_Slave
(
	.S_AXI_ACLK(clk),
	.S_AXI_ARESETN(rst_n),

	.S_AXI_AWID(M_AXI_AWID),
	.S_AXI_AWADDR(M_AXI_AWADDR),
	.S_AXI_AWLEN(M_AXI_AWLEN),
	.S_AXI_AWSIZE(3'h3),//=clogb2((`AXI_DATA_WIDTH/8)-1);
	.S_AXI_AWBURST(2'b01),
	.S_AXI_AWLOCK(1'b0),
	.S_AXI_AWCACHE(4'b0010),
	.S_AXI_AWPROT(3'h0),
	.S_AXI_AWQOS(4'h0),
	.S_AXI_AWVALID(M_AXI_AWVALID),
	.S_AXI_AWREADY(M_AXI_AWREADY),

	.S_AXI_WDATA(M_AXI_WDATA),
	.S_AXI_WSTRB(M_AXI_WSTRB),
	.S_AXI_WLAST(M_AXI_WLAST),
	.S_AXI_WVALID(M_AXI_WVALID),
	.S_AXI_WREADY(M_AXI_WREADY),

	.S_AXI_BID(M_AXI_BID),
	.S_AXI_BRESP(),//ignore
	.S_AXI_BVALID(M_AXI_BVALID),
	.S_AXI_BREADY(M_AXI_BREADY),

	.S_AXI_ARID(M_AXI_ARID),
	.S_AXI_ARADDR(M_AXI_ARADDR),
	.S_AXI_ARLEN(M_AXI_ARLEN),
	.S_AXI_ARSIZE(3'h3),//=clogb2((`AXI_DATA_WIDTH/8)-1);
	.S_AXI_ARBURST(2'b01),
	.S_AXI_ARLOCK(1'b0),
	.S_AXI_ARCACHE(4'b0010),
	.S_AXI_ARPROT(3'h0),
	.S_AXI_ARQOS(4'h0),
	.S_AXI_ARVALID(M_AXI_ARVALID),
	.S_AXI_ARREADY(M_AXI_ARREADY),

	.S_AXI_RID(M_AXI_RID),
	.S_AXI_RDATA(M_AXI_RDATA),
	.S_AXI_RRESP(),//ignore
	.S_AXI_RLAST(M_AXI_RLAST),
	.S_AXI_RVALID(M_AXI_RVALID),
	.S_AXI_RREADY(M_AXI_RREADY)
);

endmodule