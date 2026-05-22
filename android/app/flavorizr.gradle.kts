import com.android.build.gradle.AppExtension

val android = project.extensions.getByType(AppExtension::class.java)

android.apply {
    flavorDimensions("flavor-type")

    productFlavors {
        create("prd") {
            dimension = "flavor-type"
            applicationId = "com.chipmong.mini_pos"
            resValue(type = "string", name = "app_name", value = "Mini Pos")
        }
        create("dev") {
            dimension = "flavor-type"
            applicationId = "com.chipmong.mini_pos.dev"
            resValue(type = "string", name = "app_name", value = "Mini Pos DEV")
        }
    }
}