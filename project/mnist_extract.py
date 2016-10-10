from scipy import misc
import numpy as np

from tensorflow.examples.tutorials.mnist import input_data
mnist = input_data.read_data_sets("MNIST_data/", one_hot=True)
trainImages, trainLabels = mnist.train.images, mnist.train.labels
testImages, testLabels = mnist.test.images, mnist.test.labels

for i in xrange(trainImages.shape[0]):
	label = str(np.nonzero(trainLabels[i])[0][0])
	name = 'MNIST_extracted/train_images/' + label + '/' + str(i) + '.png'
	misc.imsave(name, np.reshape(trainImages[i], [28, 28]))

for i in xrange(testImages.shape[0]):
	label = str(np.nonzero(testLabels[i])[0][0])
	name = 'MNIST_extracted/test_images/' + label + '/' + str(i) + '.png'
	misc.imsave(name, np.reshape(testImages[i], [28, 28]))
