library verilog;
use verilog.vl_types.all;
entity DataMem is
    generic(
        RAM_SIZE        : integer := 32
    );
    port(
        CLK             : in     vl_logic;
        RST             : in     vl_logic;
        read            : in     vl_logic;
        write           : in     vl_logic;
        addr            : in     vl_logic_vector(4 downto 0);
        wData           : in     vl_logic_vector(31 downto 0);
        rData           : out    vl_logic_vector(31 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of RAM_SIZE : constant is 1;
end DataMem;
