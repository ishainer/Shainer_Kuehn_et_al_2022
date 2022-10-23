library(natverse)
library(rgl)
library(dendroextras)
library(nat.nblast)

# load the zebrafish brain surface file
brain_surf <- read.hxsurf("brain-outline-label.surf")

# load the neurons with their soma located within the 
# cerebellum prey capture ROI (all neurons mirrored to the left hemisphere)
SGN_neuron_left <- read.neurons("SGN_neurons_left/", pattern = ".swc")

# plot all the neurons
plot3d(brain_surf, color="Grey", alpha=0.1)
plot3d(SGN_neuron_left ,soma = 4, lwd = 2)
clear3d()

### clustering with nblast (default parameters)
kcscores <- nblast_allbyall(SGN_neuron_left)
hckcs <- nhclust(scoremat=kcscores)
dkcs <- colour_clusters(hckcs, k=4)
labels(dkcs) <- with(SGN_neuron_left[labels(dkcs)], type)
par(cex=.7)
plot(dkcs, leaflab = "none")

# plot the neurons color coded according to cluster
plot3d(brain_surf, color="Grey", alpha=0.1)
plot3d(hckcs, k=4, db=SGN_neuron_left, soma=4, lwd = 2)
clear3d()
# plot cluster 4 neurons
plot3d(brain_surf, color="Grey", alpha=0.1)
plot3d(hckcs, k=4, db=SGN_neuron_left, soma=4, lwd = 2, groups = 4)
