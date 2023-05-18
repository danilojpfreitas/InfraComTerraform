module "buckets" {

    source = "./dir_module_buckets"
    
    bucket_names = ["stack-terraform13","stack-terraform14","stack-terraform15"]
    project_name = "data-plataform"
    db_password = "MaceioAlagoas2"
    db_username = "admin"
    environment = "dev"
}