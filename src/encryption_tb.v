`timescale 1ns / 1ps

module encryption_tb(
    );
    reg [4:0] a;
    wire [4:0] b, r1, r2, r3;

    encryption e(a, b, r1, r2, r3);

    initial
    begin
        b = 5'd1;
        r1 = 5'd0;
        r2 = 5'd0;
        r3 = 5'd0;
        #30;
        b = 5'd10;
        #30;
        b = 5'd5;
        r1 = 5'd1;
        #30;
        r2 = 5'd1;
        #30;
        r3 = 5'd1;
        #30;
        r3 = 5'd26;
    end
endmodule
