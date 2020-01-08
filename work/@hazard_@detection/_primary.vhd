library verilog;
use verilog.vl_types.all;
entity Hazard_Detection is
    port(
        ID_Reg_RS       : in     vl_logic_vector(4 downto 0);
        ID_Reg_RT       : in     vl_logic_vector(4 downto 0);
        ID_EX_Addr      : in     vl_logic_vector(4 downto 0);
        stall           : out    vl_logic
    );
end Hazard_Detection;
