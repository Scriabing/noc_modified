//下面是nocif的csb2mcif系列端口，所有i都需要我们给 
//[62:0]csb2mcif_req_pd //|< i
//csb2mcif_req_pvld //|< i
//csb2mcif_req_prdy //|> 
//[33:0]mcif2csb_resp_pd //|> 
//mcif2csb_resp_valid //|> 
//addr只用低10位，而且addr的数值代表32位对齐，注意使用
//`define AXI_DATA_WIDTH 64


task mcif_conf_wr(input bit[21:0] addr, input bit[31:0] data_mcif, input bit nonposted);
begin
     @(posedge clk);//上来一拍就直接准备好全部数据，直到收到rdy（说明rdy方已经收到一拍数据，这里立刻拉低valid）
     csb2mcif_req_pvld  <= 1'b1;
     csb2mcif_req_pd <={2'b0,4'b0,1'b0,nonposted,1'b1,data_mcif,addr};//{level_NC,wrbe_NC,priv_NC,nonposted,write,wdata,addr}     
     
     @(posedge clk);
     while(csb2mcif_req_prdy !=1 ) @(posedge clk);
     csb2mcif_req_pvld <=1'b0;
     csb2mcif_req_pd <=63'b0;        
end
endtask


task mcif_conf_rd(input bit[21:0] addr, output bit[33:0] data_mcif ,input bit nonposted);
begin
     @(posedge clk);//第一拍先准备好数据，直到发现了rdy，就杀掉数据
     csb2mcif_req_pvld <= 1'b1;
     csb2mcif_req_pd <={2'b0,4'b0,1'b0,nonposted,1'b0,{(32){1'b0}},addr};//{level_NC,wrbe_NC,priv_NC,nonposted,write,wdata,addr}     
     
     @(posedge clk);//
     while(csb2mcif_req_prdy !=1 ) @(posedge clk);
     csb2mcif_req_pvld <=1'b0;
     csb2mcif_req_pd <=63'b0;
    
     @(posedge clk);
     while(mcif2csb_resp_valid !=1) @(posedge clk);
     data_mcif = mcif2csb_resp_pd;//这个读回来的数据，直接来自于NV_NVDLA_MCIF_CSB_reg 的32bit reg_rd_data
         
end
endtask




//下面是nocif的0号读口，所有i都需要我们给 
//client02mcif_rd_cdt_lat_fifo_pop   i
//client02mcif_rd_req_valid      i
//[47-1:0]client02mcif_rd_req_pd         i
//client02mcif_rd_req_ready
//client02mcif_lat_fifo_depth     i
//[4-1:0]client02mcif_rd_axid，      i        此id会一直传到axi从端

//mcif2client0_rd_rsp_valid
//[65-1:0]mcif2client0_rd_rsp_pd
//mcif2client0_rd_rsp_ready     i
task automatic CH0_rd(input bit[15-1:0] length , input bit[32-1 :0 ] addr , output bit[64-1:0] data_nocif[]);
begin
    @(posedge clk);
    client02mcif_rd_req_valid <= 1'b1;
    client02mcif_rd_req_pd <={length , addr};//size+addr
     
    @(posedge clk);
    while (!client02mcif_rd_req_ready)@(posedge clk);
    client02mcif_rd_req_valid <=1'b0;

    @(posedge clk);
    mcif2client0_rd_rsp_ready <=1'b1;
    for(int i=0;i<=length+1-1;i++)//length为0，就是大小1
    begin 
        @(posedge clk);
        while((mcif2client0_rd_rsp_ready & mcif2client0_rd_rsp_valid) != 1'b1)@(posedge clk);
        data_nocif[i] = mcif2client0_rd_rsp_pd;
    end
    mcif2client0_rd_rsp_ready <=1'b0;
end
endtask

task automatic CH1_rd(input bit[15-1:0] length , input bit[32-1 :0 ] addr , output bit[64-1:0] data_nocif[]);
begin
    @(posedge clk);
    client12mcif_rd_req_valid <= 1'b1;
    client12mcif_rd_req_pd <={length , addr};//size+addr
     
    @(posedge clk);
    while (!client12mcif_rd_req_ready)@(posedge clk);
    client12mcif_rd_req_valid <=1'b0;

    @(posedge clk);
    mcif2client1_rd_rsp_ready <=1'b1;
    for(int i=0;i<=length+1-1;i++)//length为0，就是大小1
    begin 
        @(posedge clk);
        while((mcif2client1_rd_rsp_ready & mcif2client1_rd_rsp_valid) != 1'b1)@(posedge clk);
        data_nocif[i] = mcif2client1_rd_rsp_pd;
    end
    mcif2client1_rd_rsp_ready <=1'b0;
end
endtask

task automatic CH2_rd(input bit[15-1:0] length , input bit[32-1 :0 ] addr, output bit[64-1:0] data_nocif[]);
begin
    @(posedge clk);
    client22mcif_rd_req_valid <= 1'b1;
    client22mcif_rd_req_pd <={length , addr};//size+addr
     
    @(posedge clk);
    while (!client22mcif_rd_req_ready)@(posedge clk);
    client22mcif_rd_req_valid <=1'b0;

    @(posedge clk);
    mcif2client2_rd_rsp_ready <=1'b1;
    for(int i=0;i<=length+1-1;i++)//length为0，就是大小1
    begin 
        @(posedge clk);
        while((mcif2client2_rd_rsp_ready & mcif2client2_rd_rsp_valid) != 1'b1)@(posedge clk);
        data_nocif[i] = mcif2client2_rd_rsp_pd;
    end
    mcif2client2_rd_rsp_ready <=1'b0;
end
endtask

task automatic CH3_rd( input bit[15-1:0] length , input bit[32-1 :0 ] addr ,output bit[64-1:0] data_nocif[]);
begin
    @(posedge clk);
    client32mcif_rd_req_valid <= 1'b1;
    client32mcif_rd_req_pd <={length , addr};//size+addr
     
    @(posedge clk);
    while (!client32mcif_rd_req_ready)@(posedge clk);
    client32mcif_rd_req_valid <=1'b0;

    @(posedge clk);
    mcif2client3_rd_rsp_ready <=1'b1;
    for(int i=0;i<=length+1-1;i++)//length为0，就是大小1
    begin 
        @(posedge clk);
        while((mcif2client3_rd_rsp_ready & mcif2client3_rd_rsp_valid) != 1'b1)@(posedge clk);
        data_nocif[i] = mcif2client3_rd_rsp_pd;
    end
    mcif2client3_rd_rsp_ready <=1'b0;
end
endtask

task automatic CH4_rd(input bit[15-1:0] length,input bit[32-1 :0 ] addr, output bit[64-1:0] data_nocif[]);
begin
    @(posedge clk);
    client42mcif_rd_req_valid <= 1'b1;
    client42mcif_rd_req_pd <={length , addr};//size+addr
     
    @(posedge clk);
    while (!client42mcif_rd_req_ready)@(posedge clk);
    client42mcif_rd_req_valid <=1'b0;

    @(posedge clk);
    mcif2client4_rd_rsp_ready <=1'b1;
    for(int i=0;i<=length+1-1;i++)//length为0，就是大小1
    begin 
        @(posedge clk);
        while((mcif2client4_rd_rsp_ready & mcif2client4_rd_rsp_valid) != 1'b1)@(posedge clk);
        data_nocif[i] = mcif2client4_rd_rsp_pd;
    end
    mcif2client4_rd_rsp_ready <=1'b0;
end
endtask

task automatic CH5_rd(input bit[15-1:0] length, input bit[32-1 :0 ] addr ,output bit[64-1:0] data_nocif[]);
begin
    @(posedge clk);
    client52mcif_rd_req_valid <= 1'b1;
    client52mcif_rd_req_pd <={length , addr};//size+addr
     
    @(posedge clk);
    while (!client52mcif_rd_req_ready)@(posedge clk);
    client52mcif_rd_req_valid <=1'b0;

    @(posedge clk);
    mcif2client5_rd_rsp_ready <=1'b1;
    for(int i=0;i<=length+1-1;i++)//length为0，就是大小1
    begin 
        @(posedge clk);
        while((mcif2client5_rd_rsp_ready & mcif2client5_rd_rsp_valid) != 1'b1)@(posedge clk);
        data_nocif[i] = mcif2client5_rd_rsp_pd;
    end
    mcif2client5_rd_rsp_ready <=1'b0;
end
endtask

task automatic CH6_rd( input bit[15-1:0] length , input bit[32-1 :0 ] addr , output bit[64-1:0] data_nocif[]);
begin
    @(posedge clk);
    client62mcif_rd_req_valid <= 1'b1;
    client62mcif_rd_req_pd <={length , addr};//size+addr
     
    @(posedge clk);
    while (!client62mcif_rd_req_ready)@(posedge clk);
    client62mcif_rd_req_valid <=1'b0;

    @(posedge clk);
    mcif2client6_rd_rsp_ready <=1'b1;
    for(int i=0;i<=length+1-1;i++)//length为0，就是大小1
    begin 
        @(posedge clk);
        while((mcif2client6_rd_rsp_ready & mcif2client6_rd_rsp_valid) != 1'b1)@(posedge clk);
        data_nocif[i] = mcif2client6_rd_rsp_pd;
    end
    mcif2client6_rd_rsp_ready <=1'b0;
end
endtask

task automatic CH7_rd( input bit[15-1:0] length , input bit[32-1 :0 ] addr , output bit[64-1:0] data_nocif[]);
begin
    @(posedge clk);
    client72mcif_rd_req_valid <= 1'b1;
    client72mcif_rd_req_pd <={length , addr};//size+addr
     
    @(posedge clk);
    while (!client72mcif_rd_req_ready)@(posedge clk);
    client72mcif_rd_req_valid <=1'b0;

    @(posedge clk);
    mcif2client7_rd_rsp_ready <=1'b1;
    for(int i=0;i<=length+1-1;i++)//length为0，就是大小1
    begin 
        @(posedge clk);
        while((mcif2client7_rd_rsp_ready & mcif2client7_rd_rsp_valid) != 1'b1)@(posedge clk);
        data_nocif[i] = mcif2client7_rd_rsp_pd;
    end
    mcif2client7_rd_rsp_ready <=1'b0;
end
endtask



//下面是nocif的0号写口，所有i要我们给
// [66 -1:0] client02mcif_wr_req_pd   i
//client02mcif_wr_req_valid    i
//client02mcif_wr_req_ready    
//mcif2client0_wr_rsp_complete,没有用nonposted，所以就没有compelte信号
//[3:0] client02mcif_wr_axid   i
task CH0_wr(input bit [13-1:0] size ,input bit[32-1:0] addr , input bit [4-1:0] axid , input bit [`AXI_DATA_WIDTH-1:0] data[]);
begin
    @(posedge clk);
    client02mcif_wr_req_valid <=1'b1;
    client02mcif_wr_axid <=4'b01;
    client02mcif_wr_req_pd <={1'b0,{19{1'b0}},1'b1,size,addr};
    //最高位65为0代表指令，1代表数据；64:代表写数据mask（没用到）；剩下64位代表写数据wdata；如果是指令的话，最高位65为0，低46位代表命令包，其中低32为addr，中13位size（本为计量fml，但没使用，如果不设0，那is_ftran；如果设0，那is_ftran&is_ltran），高1位require_ack
    
    @(posedge clk);
    while(client02mcif_wr_req_ready !=1'b1)@(posedge clk);
    client02mcif_wr_req_pd <=0;
    client02mcif_wr_req_valid <=1'b0;
    
    repeat (1) @(posedge clk);
    
//    @(posedge clk);
//    client02mcif_wr_req_valid <=1'b1;
//    client02mcif_wr_req_pd <={1'b1,1'b0,data[0]};//data定义在tb里
//    @(posedge clk);
//    while(client02mcif_wr_req_ready !=1'b1)@(posedge clk);
    
    for(int i=0;i<= size ;i++)
    begin
        @(posedge clk);
        client02mcif_wr_req_valid <=1'b1;
        client02mcif_wr_req_pd <={1'b1,1'b0,data[i]};    
        @(posedge clk);
        while((client02mcif_wr_req_ready & client02mcif_wr_req_valid) != 1'b1)@(posedge clk);
        client02mcif_wr_req_valid <=1'b0;
        client02mcif_wr_req_pd <=0;
    end
end
endtask   

task CH1_wr(input bit [13-1:0] size ,input bit[32-1:0] addr , input bit [4-1:0] axid , input bit [`AXI_DATA_WIDTH-1:0] data[]);
begin
    @(posedge clk);
    client12mcif_wr_req_valid <=1'b1;
    client12mcif_wr_axid <=4'b10;
    client12mcif_wr_req_pd <={1'b0,{19{1'b0}},1'b1,size,addr};
    //最高位65为0代表指令，1代表数据；64:代表写数据mask（没用到）；剩下64位代表写数据wdata；如果是指令的话，最高位65为0，低46位代表命令包，其中低32为addr，中13位size（本为计量fml，但没使用，如果不设0，那is_ftran；如果设0，那is_ftran&is_ltran），高1位require_ack
    @(posedge clk);
    while(client12mcif_wr_req_ready !=1'b1)@(posedge clk);
    client12mcif_wr_req_valid <=1'b0;
    client12mcif_wr_req_pd <=0;
    repeat (1) @(posedge clk);
     
    //    @(posedge clk);
//    client02mcif_wr_req_valid <=1'b1;
//    client02mcif_wr_req_pd <={1'b1,1'b0,data[0]};//data定义在tb里
//    @(posedge clk);
//    while(client02mcif_wr_req_ready !=1'b1)@(posedge clk);
    
    for(int i=0;i<= size ;i++)
    begin
        @(posedge clk);
        client12mcif_wr_req_valid <=1'b1;
        client12mcif_wr_req_pd <={1'b1,1'b0,data[i]};    
        @(posedge clk);
        while((client12mcif_wr_req_ready & client12mcif_wr_req_valid) != 1'b1)@(posedge clk);
        client12mcif_wr_req_valid <=1'b0;
        client12mcif_wr_req_pd <=0;
    end
endtask  

task CH2_wr(input bit [13-1:0] size ,input bit[32-1:0] addr , input bit [4-1:0] axid , input bit [`AXI_DATA_WIDTH-1:0] data[]);
begin
    @(posedge clk);
    client22mcif_wr_req_valid <=1'b1;
    client22mcif_wr_axid <=4'b11;
    client22mcif_wr_req_pd <={1'b0,{19{1'b0}},1'b1,size,addr};
    //最高位65为0代表指令，1代表数据；64:代表写数据mask（没用到）；剩下64位代表写数据wdata；如果是指令的话，最高位65为0，低46位代表命令包，其中低32为addr，中13位size（本为计量fml，但没使用，如果不设0，那is_ftran；如果设0，那is_ftran&is_ltran），高1位require_ack
    
    @(posedge clk);
    while(client22mcif_wr_req_ready !=1'b1)@(posedge clk);
    client22mcif_wr_req_valid <=1'b0;
    client22mcif_wr_req_pd <=0;
    
    repeat (1) @(posedge clk);
    
    //    @(posedge clk);
//    client02mcif_wr_req_valid <=1'b1;
//    client02mcif_wr_req_pd <={1'b1,1'b0,data[0]};//data定义在tb里
//    @(posedge clk);
//    while(client02mcif_wr_req_ready !=1'b1)@(posedge clk);
    
    for(int i=0;i<= size ;i++)
    begin
        @(posedge clk);
        client22mcif_wr_req_valid <=1'b1;
        client22mcif_wr_req_pd <={1'b1,1'b0,data[i]};    
        @(posedge clk);
        while((client22mcif_wr_req_ready & client22mcif_wr_req_valid) != 1'b1)@(posedge clk);
        client22mcif_wr_req_valid <=1'b0;
        client22mcif_wr_req_pd <=0;
    end
end
endtask      

task CH3_wr(input bit [13-1:0] size ,input bit[32-1:0] addr , input bit [4-1:0] axid , input bit [`AXI_DATA_WIDTH-1:0] data[]);
begin
    @(posedge clk);
    client32mcif_wr_req_valid <=1'b1;
    client32mcif_wr_axid <=4'b11;
    client32mcif_wr_req_pd <={1'b0,{19{1'b0}},1'b1,size,addr};
    //最高位65为0代表指令，1代表数据；64:代表写数据mask（没用到）；剩下64位代表写数据wdata；如果是指令的话，最高位65为0，低46位代表命令包，其中低32为addr，中13位size（本为计量fml，但没使用，如果不设0，那is_ftran；如果设0，那is_ftran&is_ltran），高1位require_ack
    
    @(posedge clk);
    while(client32mcif_wr_req_ready !=1'b1)@(posedge clk);
    client32mcif_wr_req_valid <=1'b0;
    client32mcif_wr_req_pd <=0;
    
    repeat (1) @(posedge clk);
    

    
    for(int i=0;i<= size ;i++)
    begin
        @(posedge clk);
        client32mcif_wr_req_valid <=1'b1;
        client32mcif_wr_req_pd <={1'b1,1'b0,data[i]};    
        @(posedge clk);
        while((client32mcif_wr_req_ready & client32mcif_wr_req_valid) != 1'b1)@(posedge clk);
        client32mcif_wr_req_valid <=1'b0;
        client32mcif_wr_req_pd <=0;
    end
end
endtask   