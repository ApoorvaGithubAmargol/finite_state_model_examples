module fsmlearn_tb;
    // Inputs
    reg clk;
    reg reset;
    reg in_bit;

    // Output
    wire detected;

    // Instantiate the FSM module
    fsmlearnnnn uut (
        .clk(clk), 
        .reset(reset), 
        .in_bit(in_bit), 
        .detected(detected)
    );

    // Clock generation
    always #5 clk = ~clk; // 10ns clock period (50MHz clock)

    // Test sequence
    initial begin
        // Initialize inputs
        clk = 0;
        reset = 1;
        in_bit = 0;

        // Wait 10ns and release reset
        #10;
        reset = 0;

        // Test Case 1: Input sequence "0011011"
        // Expected output: detected should go high at the third and sixth clock cycle
        in_bit = 0; #10;
        in_bit = 0; #10;
        in_bit = 1; #10; // State moves to S1
        in_bit = 1; #10; // State moves to S2, detected = 1
        in_bit = 0; #10; // State moves to S0
        in_bit = 1; #10; // State moves to S1
        in_bit = 1; #10; // State moves to S2, detected = 1

        // Test Case 2: Input sequence "11011"
        // Expected output: detected should go high at the second and fourth clock cycle
        reset = 1; #10; // Reset FSM
        reset = 0;

        in_bit = 1; #10; // State moves to S1
        in_bit = 1; #10; // State moves to S2, detected = 1
        in_bit = 0; #10; // State moves to S0
        in_bit = 1; #10; // State moves to S1
        in_bit = 1; #10; // State moves to S2, detected = 1

        // Test Case 3: Input sequence "100101"
        // Expected output: detected should go high at the last clock cycle
        reset = 1; #10; // Reset FSM
        reset = 0;

        in_bit = 1; #10; // State moves to S1
        in_bit = 0; #10; // State moves to S0
        in_bit = 0; #10; // Remain in S0
        in_bit = 1; #10; // State moves to S1
        in_bit = 0; #10; // State moves to S0
        in_bit = 1; #10; // State moves to S1
        in_bit = 1; #10; // State moves to S2, detected = 1

        // Finish the simulation
    end

endmodule
