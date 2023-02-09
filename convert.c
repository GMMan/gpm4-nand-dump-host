extern unsigned char* spare_buf_ptr;
unsigned int Nand_ReadPhyPage(unsigned int wPhysicPageNum, unsigned char *WorkBuffer);

struct {
    unsigned int page_num;
    unsigned int page_size;
    unsigned int spare_size;
    unsigned int num_pages_per_run;
    unsigned int max_pages;
} ctx;

void bp(void);

void main(void)
{
    while (1)
    {
        bp();
        unsigned char *buf_ptr = 0;
        for (unsigned int i = 0; i < ctx.num_pages_per_run && ctx.page_num < ctx.max_pages; ++i) {
            Nand_ReadPhyPage(ctx.page_num, buf_ptr);
            buf_ptr += ctx.page_size;
            // Copy spare
            for (unsigned int j = 0; j < ctx.spare_size; ++j) {
                *buf_ptr++ = spare_buf_ptr[j];
            }
            ++ctx.page_num;
        }
    }
}

void bp(void)
{
    return;
}
