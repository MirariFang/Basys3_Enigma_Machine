`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Digilent Inc
// Engineer: Arthur Brown
//
// Create Date: 07/27/2016 02:04:01 PM
// Design Name: Basys3 Keyboard Demo
// Module Name: top
// Project Name: Keyboard
// Target Devices: Basys3
// Tool Versions: 2016.X
// Description:
//     Receives input from USB-HID in the form of a PS/2, displays keyboard key presses and releases over USB-UART.
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//     Known issue, when multiple buttons are pressed and one is released, the scan code of the one still held down is ometimes re-sent.
//////////////////////////////////////////////////////////////////////////////////


module top(
    input         clk,
    input         PS2Data,
    input         PS2Clk,
    input [14:0] sw,
    output [6:0] seg,
    output [3:0] an,
    output [15:0] led
);
    wire        tready;
    wire        ready;
    wire        tstart;
    reg         start=0;
    reg         CLK50MHZ=0;
    wire [31:0] tbuf;
    reg  [15:0] keycodev=0;
    wire [15:0] keycode;
    wire [ 7:0] tbus;
    reg  [ 2:0] bcount=0;
    wire        flag;
    wire debugflag;
    reg         cn=0;

    always @(posedge(clk))begin
        CLK50MHZ<=~CLK50MHZ;
    end

    PS2Receiver uut (
        .clk(CLK50MHZ),
        .kclk(PS2Clk),
        .kdata(PS2Data),
        .keycode(keycode),
        .oflag(flag),
        .myflag(debugflag)
    );


    always@(keycode)
        if (keycode[7:0] == 8'hf0) begin
            cn <= 1'b0;
            bcount <= 3'd0;
        end else if (keycode[15:8] == 8'hf0) begin
            cn <= keycode != keycodev;
            bcount <= 3'd5;
        end else begin
            cn <= keycode[7:0] != keycodev[7:0] || keycodev[15:8] == 8'hf0;
            bcount <= 3'd2;
        end

    always@(posedge clk)
        if (flag == 1'b1 && cn == 1'b1) begin
            start <= 1'b1;
            keycodev <= keycode;
        end else
            start <= 1'b0;

    // bin2ascii #(
    //     .NBYTES(2)
    // ) conv (
    //     .I(keycodev),
    //     .O(tbuf)
    // );


    wire [6:0] tenthous, thous, hunds, tens, ones;

    wire [4:0] character, encrypted_char;

    bin2decimal converter(keycodev[7:0], character);
    encryption encr(encrypted_char, character, sw[4:0], sw[9:5], sw[14:10]);
    wire mod_clk1, mod_clk2;
    wire [31:0] reg_out;

    AlphabetDecoder decoder(tens, ones, encrypted_char);
    assign led[7:0] = keycodev[7:0];
    // Debugging signals
    assign led[8] = PS2Data;
    assign led[9] = PS2Clk;
    assign led[10] = debugflag;

    clock_divider #(5000) cd_fast(clk, mod_clk1);    // high frequency clock

    mux2v #(8) m0(seg, ones, tens, mod_clk1);
    assign an[3:2] = 2'b11;
    assign an[1] = mod_clk1;
    assign an[0] = ~mod_clk1;

endmodule
