`timescale 1ns / 1ps
module axis2fifo #(
    parameter AXIS_DATA_WIDTH = 32,
//    parameter AXIS_ID_WIDTH = 1,
//    parameter AXIS_DEST_WIDTH = 1,
    parameter AXIS_KEEP_WIDTH = 1,
//    parameter AXIS_STRB_WIDTH = 1,
//    parameter AXIS_USER_WIDTH = 1,
    parameter FIFO_DATA_WIDTH = 32
) (
    input clk,
    
    // AXIS SLAVE INTERFACE
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS TDATA" *)
    (* X_INTERFACE_PARAMETER = "CLK_DOMAIN /processing_system/clk_wiz_0_clk_out1" *)
    input [AXIS_DATA_WIDTH-1:0] axis_tdata,
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS TKEEP" *)
    input [AXIS_KEEP_WIDTH-1:0] axis_tkeep, // unused
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS TLAST" *)
    input axis_tlast, // unused
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS TVALID" *)
    input axis_tvalid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS TREADY" *)
    output axis_tready,
    
    (* X_INTERFACE_INFO = "xilinx.com:interface:fifo_write:1.0 M_FIFO_WRITE WR_DATA" *)
    output wire [FIFO_DATA_WIDTH-1:0] fifo_wr_data,
    (* X_INTERFACE_INFO = "xilinx.com:interface:fifo_write:1.0 M_FIFO_WRITE WR_EN" *)
    output wire fifo_wr_en,
    (* X_INTERFACE_INFO = "xilinx.com:interface:fifo_write:1.0 M_FIFO_WRITE FULL" *)
    input wire fifo_full
);  
    assign axis_tready = ~fifo_full;
    assign fifo_wr_en = axis_tready & axis_tvalid;
    assign fifo_wr_data = axis_tdata[15:0];
endmodule
