# tileserver-gl-pack
Repackaged tileserver-gl including styles and fonts

* `/fonts`
* `/styles/[name]/style-local.json`

Added styles:
* dark-matter
* klokanetech-basic
* osm-bright
* osm-bright-desaturated
* positron

# Running

```bash
docker run -it --rm docker.elastic.co/tileserver-gl-pack/tileserver-gl-pack <parameters>
```

# Testing Locally

```bash
docker build . -t tileserver-gl-pack && docker run -it --rm --entrypoint "/bin/bash" tileserver-gl-pack
```