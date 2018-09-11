# tileserver-gl-pack
Repackaged tileserver-gl including styles and fonts

* `/fonts`
* `/styles/[name]/style-local.json`

Added styles:
* dark-matter
* klokanetech-basic
* osm-bright
* positron

# Running

```bash
docker run -it --rm nyurik/tileserver-gl-pack <parameters>
```

# Testing Locally
Uncomment ENTRYPOINT and CMD lines in the Dockerfile, and run this:

```bash
docker build . -t tileserver-gl-pack -f Dockerfile && docker run -it --rm tileserver-gl-pack
```