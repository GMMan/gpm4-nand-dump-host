extern unsigned char* nand_spare_buf;
extern unsigned int SpareFlagL;
extern unsigned int SpareFlagH;
unsigned int Nand_ReadPhyPage(unsigned int wPhysicPageNum, unsigned char *WorkBuffer);
unsigned int Nand_WritePhyPage(unsigned int wPhysicPageNum, unsigned int WorkBuffer);
int Nand_ErasePhyBlock(unsigned int wPhysicBlkNum);

enum eOperation {
    OP_READ_PAGES,
    OP_WRITE_PAGE,
    OP_ERASE_BLOCK,
};

struct {
    enum eOperation op;
    unsigned int rc;
    unsigned char *buf_ptr;
    unsigned int page_num; // block_num when OP_ERASE_BLOCK
    unsigned int page_size;
    unsigned int spare_size;
    unsigned int num_pages_per_run;
    unsigned int max_pages;
    unsigned int spare_l;
    unsigned int spare_h;
} ctx;

void bp(void);

void main(void)
{
    while (1)
    {
        bp();
        switch (ctx.op) {
            case OP_READ_PAGES:
            {
                unsigned char *buf_ptr = ctx.buf_ptr;
                for (unsigned int i = 0; i < ctx.num_pages_per_run && ctx.page_num < ctx.max_pages; ++i) {
                    ctx.rc = Nand_ReadPhyPage(ctx.page_num, buf_ptr);
                    buf_ptr += ctx.page_size;
                    // Copy spare
                    for (unsigned int j = 0; j < ctx.spare_size; ++j) {
                        *buf_ptr++ = nand_spare_buf[j];
                    }
                    ++ctx.page_num;
                }
                break;
            }
            case OP_WRITE_PAGE:
            {
                SpareFlagL = ctx.spare_l;
                SpareFlagH = ctx.spare_h;
                ctx.rc = Nand_WritePhyPage(ctx.page_num, (unsigned int)ctx.buf_ptr);
                break;
            }
            case OP_ERASE_BLOCK:
            {
                ctx.rc = Nand_ErasePhyBlock(ctx.page_num);
                break;
            }
        }
    }
}

void bp(void)
{
    return;
}
