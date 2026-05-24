# Conserver les classes ObjectBox et le code natif FFI
-keep class io.objectbox.** { *; }
-dontwarn io.objectbox.**
-keep class class_package_name.entities.** { *; } # Remplacez par le chemin de vos entités si nécessaire

# Empêcher la suppression des bibliothèques natives (.so)
-keepattributes SourceFile,LineNumberTable,*Annotation*