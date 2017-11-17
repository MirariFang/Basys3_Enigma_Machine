// The inverse of rotor 2.
// Simulate the reflection signal passing through a rotor.

module rotor2_inv(
    output [4:0] out;
    input [4:0] in;
    input [4:0] rotate;
);
    wire [5:0] sum = in + 5'b26 - rotate;
    wire [4:0] M = sum % 5'd26;

    always @(M or rotate)
    begin
		if (M == 5'd6) begin
		  out = 5'd1
		end else if (M == 5'd15) begin
		  out = 5'd2
		end else if (M == 5'd11) begin
		  out = 5'd3
		end else if (M == 5'd21) begin
		  out = 5'd4
		end else if (M == 5'd4) begin
		  out = 5'd5
		end else if (M == 5'd1) begin
		  out = 5'd6
		end else if (M == 5'd26) begin
		  out = 5'd7
		end else if (M == 5'd14) begin
		  out = 5'd8
		end else if (M == 5'd17) begin
		  out = 5'd9
		end else if (M == 5'd16) begin
		  out = 5'd10
		end else if (M == 5'd24) begin
		  out = 5'd11
		end else if (M == 5'd23) begin
		  out = 5'd12
		end else if (M == 5'd2) begin
		  out = 5'd13
		end else if (M == 5'd10) begin
		  out = 5'd14
		end else if (M == 5'd9) begin
		  out = 5'd15
		end else if (M == 5'd5) begin
		  out = 5'd16
		end else if (M == 5'd8) begin
		  out = 5'd17
		end else if (M == 5'd3) begin
		  out = 5'd18
		end else if (M == 5'd13) begin
		  out = 5'd19
		end else if (M == 5'd19) begin
		  out = 5'd20
		end else if (M == 5'd7) begin
		  out = 5'd21
		end else if (M == 5'd12) begin
		  out = 5'd22
		end else if (M == 5'd18) begin
		  out = 5'd23
		end else if (M == 5'd25) begin
		  out = 5'd24
		end else if (M == 5'd20) begin
		  out = 5'd25
		end else if (M == 5'd22) begin
		  out = 5'd26
        end else
          out = 5'd0;   // If the program runs correctly, this should never be the result
        end
    end
endmodule // rotor1_inv