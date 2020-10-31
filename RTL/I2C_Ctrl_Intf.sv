//=============================================================================
//
//Module Name:					I2C_Ctrl_Intf.sv
//Department:					Xidian University
//Function Description:	        I2C控制部分接口
//
//------------------------------------------------------------------------------
//
//Version 	Design		Coding		Simulata	  Review		Rel data
//V1.0		Verdvana	Verdvana	Verdvana		  			2020-09-26
//
//------------------------------------------------------------------------------
//
//Version	Modified History
//V1.0			
//
//=============================================================================


interface I2C_Ctrl_Intf;

    logic [7:0]  device_addr;    //器件地址（8bit格式，最后1bit会被截掉）
    logic [7:0]  word_addr_h;    //字节地址高八位
    logic [7:0]  word_addr_l;    //字节地址低八位

    logic        num_word_addr;  //字节地址宽度，0为八位，1为十六位
    logic [7:0]  num_data_w;     //写数据(8bit)的个数（num_data_w+1）
    logic [7:0]  num_data_r;     //读数据(8bit)的个数（num_data_r+1）

    logic        wen;            //写使能
    logic [7:0]  wdata;          //写数据
    logic        wvalid;         //写数据有效（写完一个8bit数据会保持一个周期上升沿）

    logic        ren;            //读使能
    logic [7:0]  rdata;          //读数据
    logic        rvalid;         //读数据有效（读完一个8bit数据会保持一个周期上升沿）

    //======================================================================
    //设备侧
    modport Device(
        input   device_addr,    //器件地址（8bit格式，最后1bit会被截掉）
        input   word_addr_h,    //字节地址高八位
        input   word_addr_l,    //字节地址低八位
    
        input   num_word_addr,  //字节地址宽度，0为八位，1为十六位
        input   num_data_w,     //写数据(8bit)的个数（num_data_w+1）
        input   num_data_r,     //读数据(8bit)的个数（num_data_r+1）
    
        input   wen,            //写使能
        input   wdata,          //写数据
        output  wvalid,         //写数据有效（写完一个8bit数据会保持一个周期上升沿）
    
        input   ren,            //读使能
        output  rdata,          //读数据
        output  rvalid          //读数据有效（读完一个8bit数据会保持一个周期上升沿）
    );

    //======================================================================
    //控制器侧
    modport Controller(
        output  device_addr,    //器件地址（8bit格式，最后1bit会被截掉）
        output  word_addr_h,    //字节地址高八位
        output  word_addr_l,    //字节地址低八位
    
        output  num_word_addr,  //字节地址宽度，0为八位，1为十六位
        output  num_data_w,     //写数据(8bit)的个数（num_data_w+1）
        output  num_data_r,     //读数据(8bit)的个数（num_data_r+1）
    
        output  wen,            //写使能
        output  wdata,          //写数据
        input   wvalid,         //写数据有效（写完一个8bit数据会保持一个周期上升沿）
    
        output  ren,            //读使能
        input   rdata,          //读数据
        input   rvalid          //读数据有效（读完一个8bit数据会保持一个周期上升沿）
    );
endinterface