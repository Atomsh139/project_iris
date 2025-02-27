
# Charger le dataset Iris
data("iris")

# Consulter rapidement les premières lignes
head(iris)

# Afficher la structure des données
str(iris)

# Résumé statistique des variables
summary(iris)


# Histogramme de la variable Sepal.Length
hist(iris$Sepal.Length, 
     main="Distribution de Sepal.Length", 
     xlab="Sepal Length", 
     col="lightgreen")

# Nuage de points (Sepal.Length vs Sepal.Width)
plot(iris$Sepal.Length, iris$Sepal.Width, 
     xlab="Sepal Length", ylab="Sepal Width", 
     col="blue",
     main="Sepal.Length vs Sepal.Width")

# Vérifier les valeurs manquantes
sum(is.na(iris))  # Nombre total de NA

# Vérifier si des lignes sont dupliquées
sum(duplicated(iris))

# Installer et charger ggplot2 si nécessaire
# install.packages("ggplot2")
library(ggplot2)

# Distribution de la longueur des pétales par espèce
ggplot(iris, aes(x=Species, y=Petal.Length, fill=Species)) +
  geom_boxplot() +
  labs(title="Distribution de la longueur des pétales par espèce",
       x="Espèce",
       y="Longueur des pétales") +
  theme_minimal()

set.seed(123)  # Pour reproduire les résultats
indexes <- sample(1:nrow(iris), size = 0.7*nrow(iris))

train_data <- iris[indexes, ]
test_data  <- iris[-indexes, ]


# Si le package n'est pas installé : install.packages("MASS")
library(MASS)

# Construire le modèle LDA
model_lda <- lda(Species ~ ., data = train_data)
model_lda

# Prédire les espèces sur le jeu de test
predictions <- predict(model_lda, newdata=test_data)
head(predictions$class)


# Calculer la matrice de confusion
confusion_matrix <- table(Predicted = predictions$class, 
                          Actual = test_data$Species)
confusion_matrix

# Calculer la précision globale
accuracy <- sum(diag(confusion_matrix)) / sum(confusion_matrix)
accuracy

