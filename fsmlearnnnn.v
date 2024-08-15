`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:29:27 08/15/2024 
// Design Name: 
// Module Name:    fsmlearnnnn 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module fsmlearnnnn(
    input wire clk,       // Clock signal
    input wire reset,     // Reset signal
    input wire in_bit,    // Input bit (stream)
    output reg detected   // Output signal (1 if "11" is detected)
);

    // State encoding using localparam
    localparam S0 = 2'b00; // Initial state
    localparam S1 = 2'b01; // First '1' detected
    localparam S2 = 2'b10; // Pair "11" detected

    reg [1:0] state, next_state;

    // State transition logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= S0;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic and output logic
    always @(*) begin
        case (state)
            S0: begin
                detected = 0;
                if (in_bit == 1)
                    next_state = S1;
                else
                    next_state = S0;
            end
            S1: begin
                detected = 0;
                if (in_bit == 1)
                    next_state = S2;
                else
                    next_state = S0;
            end
            S2: begin
                detected = 1;
                if (in_bit == 1)
                    next_state = S1;
                else
                    next_state = S0;
            end
            default: begin
                detected = 0;
                next_state = S0;
            end
        endcase
    end

endmodule
