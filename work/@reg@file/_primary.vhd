library verilog;
use verilog.vl_types.all;
entity RegFile is
    port(
        CLK             : in     vl_logic;
        RST             : in     vl_logic;
        rs              : in     vl_logic_vector(4 downto 0);
        rt              : in     vl_logic_vector(4 downto 0);
        write           : in     vl_logic_vector(4 downto 0);
        writeData       : in     vl_logic_vector(31 downto 0);
        RegWre          : in     vl_logic;
        rd              : in     vl_logic_vector(4 downto 0);
        RegDst          : in     vl_logic;
        readData1       : out    vl_logic_vector(31 downto 0);
        readData2       : out    vl_logic_vector(31 downto 0);
        addr            : out    vl_logic_vector(4 downto 0)
    );
end RegFile;
