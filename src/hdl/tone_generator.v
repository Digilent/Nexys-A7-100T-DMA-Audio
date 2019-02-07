`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/15/2019 01:25:16 PM
// Design Name: 
// Module Name: tone_generator
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tone_generator #(
    parameter AXIS_DATA_WIDTH = 32,
    parameter AXIS_KEEP_WIDTH = AXIS_DATA_WIDTH / 8,
    parameter AXIS_CLK_DOMAIN = "",
    parameter TONE_FREQ = 261,
    parameter AUD_SAMPLE_FREQ = 96000,
    parameter PACKET_SIZE = 256,
    parameter PACKET_SIZE_CLOG2 = 8
) (
    input clk,
    
    // AXIS MASTER INTERFACE
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS TDATA" *)
    (* X_INTERFACE_PARAMETER = "CLK_DOMAIN /processing_system/clk_wiz_0_clk_out1" *)
    output [AXIS_DATA_WIDTH-1:0] axis_tdata,
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS TVALID" *)
    output axis_tvalid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS TLAST" *)
    output axis_tlast,
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS TREADY" *)
    input axis_tready,
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS TKEEP" *)
    output [AXIS_KEEP_WIDTH-1:0] axis_tkeep
    
    //,output wire dbg
);
    localparam ACCUMULATOR_DEPTH = 32;
    localparam INCREMENT = 32'h00B22D0E;//(2**ACCUMULATOR_DEPTH) / (AUD_SAMPLE_FREQ/TONE_FREQ);

    assign axis_tvalid = 1; // generation of new data takes place immediately - hold valid high.
    
    reg [ACCUMULATOR_DEPTH-1:0] duty = 0; // DATA generation
    always@(posedge clk)
        if (axis_tvalid & axis_tready) begin
            duty <= duty + INCREMENT;
        end
    assign axis_tdata = {{(AXIS_DATA_WIDTH-16){1'b0}}, duty[ACCUMULATOR_DEPTH-1:ACCUMULATOR_DEPTH-16]};
    
    reg [$clog2(PACKET_SIZE)-1:0] packet_count = 0; // LAST generation
    always@(posedge clk)
        if (axis_tvalid & axis_tready) begin
            if (packet_count >= PACKET_SIZE)
                packet_count <= 'b0;
            else
                packet_count <= packet_count + 1;
        end
    assign axis_tlast = 1'b1;//(packet_count == PACKET_SIZE-1);
    assign axis_tkeep = 4'hF; // we want the downstream ip to see all bytes produced by this module

    // TODO: create AXI interface for configuration of INCREMENT and PACKET_SIZE params
endmodule
