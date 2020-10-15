//=============================================================================
//
//Module Name:					I2C_Top.sv
//Department:					Xidian University
//Function Description:	        I2C控制器顶层
//
//------------------------------------------------------------------------------
//
//Version 	Design		Coding		Simulata	  Review		Rel data
//V1.0		Verdvana	Verdvana	Verdvana		  			2020-09-26
//
//------------------------------------------------------------------------------
//
//Version	Modified History
//V1.0      I2C_Controller的wrapper
//          包含I2C中实际的双向sda PAD
//
//=============================================================================

`timescale 1ns/1ps

module I2C_Top #(
    parameter   SYS_CLOCK = 50_000_000, //系统时钟频率
                SCL_CLOCK = 400_000     //I2C时钟频率
)(
    input  logic        clk,            //系统时钟
    input  logic        rst_n,          //异步复位

    input  logic [7:0]  device_addr,    //器件地址（8bit格式，最后1bit会被截掉）
    input  logic [7:0]  word_addr_h,    //字节地址高八位
    input  logic [7:0]  word_addr_l,    //字节地址低八位

    input  logic        num_word_addr,  //字节地址宽度，0为八位，1为十六位
    input  logic [7:0]  num_data_w,     //写数据(8bit)的个数（num_data_w+1）
    input  logic [7:0]  num_data_r,     //读数据(8bit)的个数（num_data_r+1）

    input  logic        wen,            //写使能
    input  logic [7:0]  wdata,          //写数据
    output logic        wvalid,         //写数据有效（写完一个8bit数据会保持一个周期上升沿）

    input  logic        ren,            //读使能
    output logic [7:0]  rdata,          //读数据
    output logic        rvalid,         //读数据有效（读完一个8bit数据会保持一个周期上升沿）

    output logic        ready,          //准备好传输
    output logic        done,           //传输完成
    output logic        error,          //传输有误

    output logic        scl,            //scl
    inout  wire         sda             //sda
    );

    logic   sda_i,sda_o,sda_en;

    assign  sda      = sda_en ? sda_o : 1'bz;
    assign  sda_i    = sda;

    I2C_Controller #(
        .SYS_CLOCK(SYS_CLOCK),
        .SCL_CLOCK(SCL_CLOCK)
    )u_I2C_Controller(
        .clk(clk),
        .rst_n(rst_n),

        .device_addr(device_addr),
        .word_addr_h(word_addr_h),
        .word_addr_l(word_addr_l),

        .num_word_addr(num_word_addr),
        .num_data_w(num_data_w),
        .num_data_r(num_data_r),

        .wen(wen),
        .wdata(wdata),
        .wvalid(wvalid),

        .ren(ren),
        .rdata(rdata),
        .rvalid(rvalid),

        .scl(scl),
        .sda_i(sda_i),
        .sda_o(sda_o),
        .sda_en(sda_en),

        .ready(ready),
        .done(done),
        .error(error)
    );

    
endmodule