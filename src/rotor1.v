// Rotor 1 of the enigma machine
// Contains a map from inputs to corresponding outputs
// rotate modifies the output value, simulating the rotation process

module rotor1(out, in, rotate);
    output [4:0] out;
    input [4:0] in;
    input [4:0] rotate;

    reg [4:0] M;    // intermediate value

    always @(in or rotate)
    begin
		if (in == 5'd1) begin
		  M = 5'd16;
		end else if (in == 5'd2) begin
		  M = 5'd25;
		end else if (in == 5'd3) begin
		  M = 5'd13;
		end else if (in == 5'd4) begin
		  M = 5'd4;
		end else if (in == 5'd5) begin
		  M = 5'd17;
		end else if (in == 5'd6) begin
		  M = 5'd7;
		end else if (in == 5'd7) begin
		  M = 5'd14;
		end else if (in == 5'd8) begin
		  M = 5'd3;
		end else if (in == 5'd9) begin
		  M = 5'd8;
		end else if (in == 5'd10) begin
		  M = 5'd19;
		end else if (in == 5'd11) begin
		  M = 5'd22;
		end else if (in == 5'd12) begin
		  M = 5'd11;
		end else if (in == 5'd13) begin
		  M = 5'd23;
		end else if (in == 5'd14) begin
		  M = 5'd18;
		end else if (in == 5'd15) begin
		  M = 5'd1;
		end else if (in == 5'd16) begin
		  M = 5'd15;
		end else if (in == 5'd17) begin
		  M = 5'd6;
		end else if (in == 5'd18) begin
		  M = 5'd24;
		end else if (in == 5'd19) begin
		  M = 5'd21;
		end else if (in == 5'd20) begin
		  M = 5'd9;
		end else if (in == 5'd21) begin
		  M = 5'd10;
		end else if (in == 5'd22) begin
		  M = 5'd20;
		end else if (in == 5'd23) begin
		  M = 5'd5;
		end else if (in == 5'd24) begin
		  M = 5'd2;
		end else if (in == 5'd25) begin
		  M = 5'd26;
		end else if (in == 5'd26) begin
		  M = 5'd12;
        end else begin
          M = 5'd0; // If the program runs correctly, this should never be the result
        end
    end
    
    wire [5:0] sum = M + rotate;
    assign out = sum % 5'd26;

endmodule