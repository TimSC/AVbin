LIBNAME=$(OUTDIR)/avbin.dll

CC = i686-w64-mingw32-gcc

CFLAGS += -O3
LDFLAGS += -shared -mno-cygwin -Wl,-allow-multiple-definition

STATIC_LIBS = -Wl,-whole-archive \
              -Wl,$(BACKEND_DIR)/libavformat/libavformat.a \
              -Wl,$(BACKEND_DIR)/libavcodec/libavcodec.a \
              -Wl,$(BACKEND_DIR)/libavutil/libavutil.a \
              -Wl,$(BACKEND_DIR)/libswscale/libswscale.a \
              -Wl,/usr/i686-w64-mingw32/lib/libz.a \
              -Wl,/usr/i686-w64-mingw32/lib/libbz2.a \
              -Wl,-no-whole-archive \
              -Wl,-out-implib,$(OUTDIR)/avbin.lib

# Linking crashes when -lbz2 is present
#LIBS = -lm -lws2_32 -lvfw32 -lbz2
LIBS = -lm -lws2_32

$(LIBNAME) : $(OBJNAME) $(OUTDIR)
	$(CC) $(LDFLAGS) -o $@ $< $(STATIC_LIBS) $(LIBS)
