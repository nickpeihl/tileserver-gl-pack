FROM klokantech/tileserver-gl:latest
MAINTAINER Yuri Astrakhan <yuriastrakhan@gmail.com>

RUN apt-get -qq update \
 && DEBIAN_FRONTEND=noninteractive apt-get -y install \
    jq \
 && apt-get clean \
 && mkdir -p /usr/src/sprites \
 && cd /usr/src/sprites \
 && npm --silent --no-save --no-progress install @mapbox/spritezero-cli

# consider installing other fonts:
# ttf-unifont fonts-noto-cjk fonts-noto-hinted fonts-noto-unhinted fonts-hanazono \

#
# Download fonts and place them into the font assets dir
#

RUN FONT_DIR=/fonts \
 && echo "FONTS: Downloading fonts to $FONT_DIR" \
 && curl -s -L https://github.com/openmaptiles/fonts/releases/download/v2.0/v2.0.zip -o /tmp/fonts.zip \
 && mkdir -p $FONT_DIR \
 && unzip -q /tmp/fonts.zip -d $FONT_DIR \
 && rm /tmp/fonts.zip

#
# Download the snapshot of the master branch of all known styles directly to the target dir
# Morph style.json into style-local.json by adjusting hardcoded values
#

RUN echo "STYLES: Downloading and modifying style files" \
 && STYLE=dark-matter \
 && STYLE_DIR=/styles/$STYLE \
 && echo "Downloading style $STYLE" \
 && mkdir -p $STYLE_DIR \
 && curl -s -L https://github.com/openmaptiles/$STYLE-gl-style/tarball/master | tar xz --strip=1 -C $STYLE_DIR \
 && cat $STYLE_DIR/style.json | jq '.sources.openmaptiles.url = "mbtiles://{v3}" | .sprite = "{styleJsonFolder}/sprite" | .glyphs = "{fontstack}/{range}.pbf"' > $STYLE_DIR/style-local.json \
 && /usr/src/sprites/node_modules/.bin/spritezero $STYLE_DIR/sprite $STYLE_DIR/icons \
 && /usr/src/sprites/node_modules/.bin/spritezero --retina $STYLE_DIR/sprite@2x $STYLE_DIR/icons \
 \
 && STYLE=klokantech-basic \
 && STYLE_DIR=/styles/$STYLE \
 && echo "Downloading style $STYLE" \
 && mkdir -p $STYLE_DIR \
 && curl -s -L https://github.com/openmaptiles/$STYLE-gl-style/tarball/master |  tar xz --strip=1 -C $STYLE_DIR \
 && cat $STYLE_DIR/style.json | jq '.sources.openmaptiles.url = "mbtiles://{v3}" | .sprite = "{styleJsonFolder}/sprite" | .glyphs = "{fontstack}/{range}.pbf"' > $STYLE_DIR/style-local.json \
 && /usr/src/sprites/node_modules/.bin/spritezero $STYLE_DIR/sprite $STYLE_DIR/icons \
 && /usr/src/sprites/node_modules/.bin/spritezero --retina $STYLE_DIR/sprite@2x $STYLE_DIR/icons \
 \
 && STYLE=osm-bright \
 && STYLE_DIR=/styles/$STYLE \
 && echo "Downloading style $STYLE" \
 && mkdir -p $STYLE_DIR \
 && curl -s -L https://github.com/elastic/$STYLE-gl-style/tarball/master | tar xz --strip=1 -C $STYLE_DIR \
 && cat $STYLE_DIR/style.json | jq '.sources.openmaptiles.url = "mbtiles://{v3}" | .sprite = "{styleJsonFolder}/sprite" | .glyphs = "{fontstack}/{range}.pbf"' > $STYLE_DIR/style-local.json \
 && /usr/src/sprites/node_modules/.bin/spritezero $STYLE_DIR/sprite $STYLE_DIR/icons \
 && /usr/src/sprites/node_modules/.bin/spritezero --retina $STYLE_DIR/sprite@2x $STYLE_DIR/icons \
 \
 && STYLE=osm-bright-desaturated \
 && STYLE_DIR=/styles/$STYLE \
 && echo "Downloading style $STYLE" \
 && mkdir -p $STYLE_DIR \
 && curl -s -L https://github.com/elastic/$STYLE-gl-style/tarball/master | tar xz --strip=1 -C $STYLE_DIR \
 && cat $STYLE_DIR/style.json | jq '.sources.openmaptiles.url = "mbtiles://{v3}" | .sprite = "{styleJsonFolder}/sprite" | .glyphs = "{fontstack}/{range}.pbf"' > $STYLE_DIR/style-local.json \
 && /usr/src/sprites/node_modules/.bin/spritezero $STYLE_DIR/sprite $STYLE_DIR/icons \
 && /usr/src/sprites/node_modules/.bin/spritezero --retina $STYLE_DIR/sprite@2x $STYLE_DIR/icons \
 \
 && STYLE=positron \
 && STYLE_DIR=/styles/$STYLE \
 && echo "Downloading style $STYLE" \
 && mkdir -p $STYLE_DIR \
 && curl -s -L https://github.com/openmaptiles/$STYLE-gl-style/tarball/master | tar xz --strip=1 -C $STYLE_DIR \
 && cat $STYLE_DIR/style.json | jq '.sources.openmaptiles.url = "mbtiles://{v3}" | .sprite = "{styleJsonFolder}/sprite" | .glyphs = "{fontstack}/{range}.pbf"' > $STYLE_DIR/style-local.json \
 && /usr/src/sprites/node_modules/.bin/spritezero $STYLE_DIR/sprite $STYLE_DIR/icons \
 && /usr/src/sprites/node_modules/.bin/spritezero --retina $STYLE_DIR/sprite@2x $STYLE_DIR/icons \
 \
 && : # done styling

#ENTRYPOINT []
#CMD [ "/bin/bash" ]
