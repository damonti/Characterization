# Automated flow for power modelling based on component's features

This work proposes an automated flow for early-stage dynamic power estimation by using a class of workloads for power characterization purposes. Such characterization is performed by mapping the input/output average switching activity derived from the workloads to post-synthesis accurate power numbers. The mapping can be performed for various parameters' configuration of the chosen hardware. To build the power model, different machine learning regression algorithms are evaluated. Once the model is built, post-synthesis accurate power numbers are inferred by providing the average input/output hardware activity. This returns instant average dynamic power estimation while keeping the error reasonable. For the cases studied, the returned error compared to ground truth is about 2%.

MSc thesis: https://github.com/damonti/Characterization/blob/main/doc/Graduation%20report%20Monticelli.pdf
