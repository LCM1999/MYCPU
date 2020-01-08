library verilog;
use verilog.vl_types.all;
entity BypassContral is
    port(
        ID_EX_Reg_RS    : in     vl_logic_vector(4 downto 0);
        ID_EX_Reg_RT    : in     vl_logic_vector(4 downto 0);
        EX_MEM_Reg_RD   : in     vl_logic_vector(4 downto 0);
        EX_MEM_RegWre   : in     vl_logic;
        MEM_WB_Reg_RD   : in     vl_logic_vector(4 downto 0);
        MEM_WB_RegWre   : in     vl_logic;
        ForwardA        : out    vl_logic_vector(1 downto 0);
        ForwardB        : out    vl_logic_vector(1 downto 0)
    );
end BypassContral;
